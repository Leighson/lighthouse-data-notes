/* global grecaptcha $ */
/* eslint-disable prefer-template */

$.fn.serializeObject = function () {
    return this.serializeArray().reduce(function (agg, object) {
        agg[object.name] = object.value;
        return agg;
    }, {});
};
(function () {
    function defaultHrefMaker(res) {
        return res.temp ? '/reset' : '/';
    }
    $.fn.loginForm = function ($loginError, hrefMaker) {
        hrefMaker = hrefMaker || defaultHrefMaker;
        var $form = this;
        this.on('submit', function (evt) {
            evt.preventDefault();
            var data = $form.serializeObject();
            if (!data.email || !data.password) {
                $($loginError).text('You must fill in all fields.');
            } else {
                $($loginError).text('');
                $.post(
                    '/login',
                    data,
                    function (res) {
                        if (res.success) {
                            window.location.href = hrefMaker(res);
                        } else {
                            $($loginError).text(res.message);
                        }
                    },
                    'json'
                );
            }
        });
        return this;
    };

    $.fn.registrationForm = function ($registerError, hrefMaker) {
        hrefMaker = hrefMaker || defaultHrefMaker;
        var $form = this;
        var $registrationFieldErrors = this.find('.field-error');
        var $registrationInputs = this.find('input');
        $registrationInputs.on('blur', function () {
            $registrationFieldErrors
                .filter('[data-field="' + $(this).attr('name') + '"]')
                .text('');
        });
        this.on('submit', function (evt) {
            evt.preventDefault();
            var data = $form.serializeObject();
            if (data.dateOfBirthYear) {
                data.dateOfBirth = new Date(
                    Number(data.dateOfBirthYear),
                    Number(0), // Month = January (0)
                    Number(1) // Day = 1
                );
            }
            // if(data.dateOfBirthDay && data.dateOfBirthMonth && data.dateOfBirthYear){
            //   data.dateOfBirth = new Date(
            //     Number(data.dateOfBirthYear),
            //     Number(data.dateOfBirthMonth),
            //     Number(data.dateOfBirthDay)
            //   );
            // }
            if ($('#subscribe-checkbox')[0].checked) {
                data.subscribe = true;
            }
            if ($('#alumni-checkbox')[0].checked) {
                data.alumni = true;
            }
            if ($('#agree-checkbox')[0].checked) {
                data.agree = true;
            }

            // if ($('#subscribe-community')[0].checked) {
            //   data.subscribeCommunity = true;
            // }
            data.captcha = grecaptcha.getResponse();
            $.post('/register', data, function (res) {
                if (res.success) {
                    window.location.href = hrefMaker(res);
                } else {
                    grecaptcha.reset();
                    $($registerError).text(res.message);
                    $registrationFieldErrors.text('');
                    for (var field in res.errors) {
                        $registrationFieldErrors
                            .filter('[data-field="' + field + '"]')
                            .text(res.errors[field].join(', '));
                    }
                }
            });
        });
        return this;
    };
})();
