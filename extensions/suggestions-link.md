Suggestions link
================

The purpose of this extension is to provide suggestions for form input values.

Server implementations MAY add `suggestions` to an input element form. The format of the link SHOULD use [URI Templates](http://tools.ietf.org/html/rfc6570). The single variable `query` SHOULD be present in the URI template

Clients that understand this extension can query the server and ask for suggestions as the user is typing. The user input SHOULD be sent via [URI Template](http://tools.ietf.org/html/rfc6570) using the safe method of the given protocol, i.e. `GET` for HTTP.

Consider the following example:

```json
{
  "href": "/messages",
  "submit": {
    "action": "/messages",
    "method": "POST",
    "input": {
      "recipient": {
        "type": "email",
        "suggestions": {
          "href": "/users{?query}",
          "throttle": 200
        },
        "required": true
      },
      "message": {
        "type": "text",
        "required": true
      }
    }
  }
}
```

In the preceeding example the system accepts messages sent to other users in the system. For a client to know which possible values exist for the `recipient` field, the `suggestions` link could be followed as the user typed another user's email.

Servers MAY specify a `throttle` in milliseconds indicating the request will be throttled to the specified amount and should be respected by clients as to not overwhelm servers. If the `throttle` property is not present the suggested period should be 100ms.
