/* global $ */
/* eslint-disable prefer-template */
$(function () {
    var $form = $("form");
    var $formErrorFields = $form.find(".field-error");
    var formErrorsByField = {};
    $formErrorFields.each(function (index, item) {
        var $item = $(item);
        formErrorsByField[$item.data("field")] = $item;
    });

    $form.on("submit", function (event) {
        event.preventDefault();
        var data = $form.serializeObject();
        data.code_required = data.code_required === "true" ? true : undefined;
        $.post("/teams/create", data, function (res) {
            if (res.success) {
                window.location.href = "/teams/instructions";
            } else {
                console.log(res.errors);
                for (var errorField in res.errors) {
                    if (formErrorsByField[errorField]) {
                        formErrorsByField[errorField].text(res.errors[errorField]);
                    }
                }
            }
        });
    });

    var $privateTeamCode = $form.find(".private-team-code");
    $form.find("input[type=radio]").on("change", function () {
        if (this.value === "true") {
            $privateTeamCode.slideDown();
        } else {
            $privateTeamCode.slideUp();
        }
    });

    $form.find("input[type=text]").on("blur", function () {
        if (formErrorsByField[this.name]) {
            formErrorsByField[this.name].text("");
        }
    });
});
