/* global $ */

$.fn.serializeObject = function () {
    return this.serializeArray().reduce(function (agg, object) {
        agg[object.name] = object.value;
        return agg;
    }, {});
};

window.formHandlerMaker = function formHandlerMaker(
    $form,
    validator,
    hrefMaker
) {
    function formHandler(res) {
        var href = hrefMaker(res);
        if (href) {
            window.location.href = href;
        } else {
            $("#error").text(res.message);
        }
    }

    $form.on("submit", function (event) {
        event.preventDefault();
        var validatorOutput = validator($form);
        if (validatorOutput.error) {
            $("#error").text(validatorOutput.error);
        } else {
            $.post(validatorOutput.route, validatorOutput.data, formHandler, "json");
        }
    });
};
