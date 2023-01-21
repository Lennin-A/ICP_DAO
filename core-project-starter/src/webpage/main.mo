import Http "./http";
import Text "mo:base/Text";
import Opt "mo:base/Option";


actor {
    public type HttpRequest = Http.HttpRequest;
    public type HttpResponse = Http.HttpResponse;

    var title = "hello world";

    //browser calls http_request() 
    public query func http_request() : async HttpResponse {
        return ({
            body = Text.encodeUtf8(title);
            headers = [];
            status_code = 200;
            streaming_strategy = null;
        })
    };

    public func update_page(msg : Text) : async () {
        title := msg
    };
};
