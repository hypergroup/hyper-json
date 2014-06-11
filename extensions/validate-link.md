Validate link
=============

The purpose of this extension is to provide validations for form input values.

Server implementations MAY add `validate` to an input element form. The format of the link SHOULD use [URI Templates](http://tools.ietf.org/html/rfc6570). The template SHOULD use one and only one templated field. The name of the parameter should be conform to the [specification](http://tools.ietf.org/html/rfc6570). For example, if the search parameter was `value` a server would use the following format:

```
http://example.com/validations{?value}
```

If the server needed additional context about the validations more parameters could be added to the uri:

```
http://example.com/validations?type=email&min-length=5{&value}
```

Clients that understand this extension can query the server and ask if a value is valid. The user input SHOULD be sent via [URI Template](http://tools.ietf.org/html/rfc6570) using the safe method of the given protocol, i.e. `GET` for HTTP. A client SHOULD use the first field it encounters in the template.

Consider the following example:

```json
{
  "href": "/images",
  "submit": {
    "action": "/images",
    "method": "POST",
    "input": {
      "image": {
        "type": "href",
        "validate": {
          "href": "/validations?type=image/jpg&min-size=400x400{&value}"
        },
        "required": true
      }
    }
  }
}
```

In the preceeding example the system accepts an image which is a `image/jpeg` and a minimum size of `400x400`.

If the value is valid the server SHOULD respond with the following:

```json
{
  "valid": true
}
```

If the value has errors the server SHOULD respond with the following:

```json
{
  "valid": false,
  "invalid": {
    "type": {
      "message": "This server only accepts 'image/jpeg'"
    }
  }
}
```

The server MAY also return warnings:

```json
{
  "valid": true,
  "warnings": {
    "size": {
      "message": "The size of the image is a little low."
    }
  }
}
```
