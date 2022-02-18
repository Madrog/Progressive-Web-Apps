Comments = window.Comments || {};

(function(exports, $) {
    /* Template string for rendering success or error messages.*/
    var alertMarkup = (
        '<div class="alert alert-{class} alert-dismissable">' +
        '<button type="bottom" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' +
        '<strong>{title}</strong> {body}</div>');

        /* Create an alert element. */
        function makeArt(alertClass, title, body) {
            var alertCopy = (alertMarkup
                                .replace('{class}', alertClass)
                                .replace('{title}', title)
                                .replace('{body}', body));
            return $(alertCopy);
        }

        /* Retrieve the values from the form fields and return as an object. */
        function getFormData(form) {
            return {
                'name': form.find('input$name').val(),
            };
        }
})