"use strict";
XML.prettyPrinting   = false;
XML.ignoreWhitespace = false;
var INFO =
<plugin name="http-headers" version="0.3"
        href="http://dactyl.sf.net/pentadactyl/plugins#http-headers-plugin"
        summary="HTTP header info"
        xmlns={NS}>
    <author email="maglione.k@gmail.com">Kris Maglione</author>
    <license href="http://opensource.org/licenses/mit-license.php">MIT</license>
    <project name="Pentadactyl" min-version="1.0"/>
    <p>
        Adds request and response headers to the <ex>:pageinfo</ex>
        command, with the keys <em>h</em> and <em>H</em> respectively.
        See also <o>pageinfo</o>.
    </p>
    <example><ex>:pageinfo hH</ex></example>
</plugin>;

var Ci = Components.interfaces;

var Controller = Class("Controller", XPCOM(Ci.nsIController), {
    init: function (command, data) {
        this.command = command;
        this.data = data;
    },
    supportsCommand: function (cmd) cmd === this.command
});

var HttpObserver = Class("HttpObserver",
    XPCOM([Ci.nsIObserver, Ci.nsISupportsWeakReference, Ci.nsIWebProgressListener]), {
    init: function (name, store) {
        util.addObserver(this);
    },

    extractHeaders: function (request, type) {
        let major = {}, minor = {};
        request.QueryInterface(Ci.nsIHttpChannelInternal)["get" + type + "Version"](major, minor);

        let headers = [[type.toUpperCase(), "HTTP/" + major.value + "." + minor.value]];
        request["visit" + type + "Headers"]({
            visitHeader: function (header, value) {
                headers.push([header, value]);
            }
        });
        return headers;
    },

    getHeaders: function (webProgress, request) {
        try {
            let win = webProgress.DOMWindow;
            if (win && /^https?$/.test(request.URI.scheme)) {
                if (request instanceof Ci.nsIHttpChannel)
                    request.QueryInterface(Ci.nsIHttpChannel);
                else {
                    request.QueryInterface(Ci.nsIMultiPartChannel);
                    request.baseChannel.QueryInterface(Ci.nsIHttpChannel);
                }

                let store = win.dactylStore = win.dactylStore || {};
                store.requestHeaders = this.extractHeaders(request, "Request");
                store.responseHeaders = this.extractHeaders(request, "Response");

                store.requestHeaders[0][1] = request.requestMethod + " " +
                    request.URI.spec + " " + store.requestHeaders[0][1];
                store.responseHeaders[0][1] += " " + request.responseStatus + " " +
                    request.responseStatusText;

                let controller = win.controllers.getControllerForCommand("dactyl-headers");
                if (controller)
                    win.controllers.removeController(controller);
                win.controllers.appendController(Controller("dactyl-headers", store));
            }
        }
        catch (e) {}
    },

    observe: {
        "http-on-examine-response": function (subject, data) {
            try {
                subject.QueryInterface(Ci.nsIChannel).QueryInterface(Ci.nsIHttpChannel).QueryInterface(Ci.nsIRequest);

                if (subject.loadFlags & subject.LOAD_DOCUMENT_URI)
                    subject.loadGroup.groupObserver.QueryInterface(Ci.nsIWebProgress)
                           .addProgressListener(this, Ci.nsIWebProgress.NOTIFY_STATE_DOCUMENT);
            }
            catch (e) {}
        }
    },

    onStateChange: function(webProgress, request, stateFlags, status) {
        if ((stateFlags & this.STATE_START) && (stateFlags & this.STATE_IS_DOCUMENT))
            this.getHeaders(webProgress, request);
        else if ((stateFlags & this.STATE_STOP) && (stateFlags & this.STATE_IS_DOCUMENT)) {
            this.getHeaders(webProgress, request);
            try {
                webProgress.removeProgressListener(this);
            } catch (e) {}
        }
    }
});

let observer = storage.newObject("http-headers", HttpObserver, { store: false });

function iterHeaders(type) {
    let win = buffer.focusedFrame;
    let store = win.dactylStore || win.controllers.getControllerForCommand("dactyl-headers");
    if (win.dactylStore)
        for (let [k, v] in values(win.dactylStore[type + "Headers"] || []))
            yield [k, v];
}

for (let [key, name] in Iterator({ h: "Request", H: "Response" }))
    buffer.addPageInfoSection(key, name + " Headers", function (verbose) {
        if (verbose)
            return iterHeaders(name.toLowerCase())
    });

/* vim:se sts=4 sw=4 et: */
