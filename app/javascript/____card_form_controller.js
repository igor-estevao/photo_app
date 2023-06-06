document.addEventListener('DOMContentLoaded', function() {
  var show_error, stripeResponseHandler, submitHandler;

  submitHandler = function(event) {
    var form = event.target;
    form.querySelector("input[type=submit]").disabled = true;

    // If Stripe was initialized correctly, this will create a token using the credit card info
    if (typeof Stripe !== 'undefined') {
      Stripe.card.createToken(form, stripeResponseHandler);
    } else {
      show_error("Failed to load credit card processing functionality. Please reload this page in your browser.");
    }

    return false;
  };

  document.querySelectorAll(".cc_form").forEach(function(form) {
    form.addEventListener('submit', submitHandler());
  });

  stripeResponseHandler = function(status, response) {
    var token, form;

    form = document.querySelector('.cc_form');

    if (response.error) {
      console.log(response.error.message);
      show_error(response.error.message);
      form.querySelector("input[type=submit]").disabled = false;
    } else {
      token = response.id;
      var hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'payment[token]');
      hiddenInput.value = token;
      form.appendChild(hiddenInput);

      var stripeInputs = form.querySelectorAll("[data-stripe]");
      stripeInputs.forEach(function(input) {
        input.remove();
      });

      form.submit();
    }

    return false;
  };

  show_error = function(message) {
    var flashMessages = document.getElementById("flash-messages");
    if (!flashMessages) {
      var container = document.querySelector("div.container.main div:first");
      container.insertAdjacentHTML('beforebegin', '<div id="flash-messages"></div>');
    }

    var flashAlert = document.getElementById("flash_alert");
    flashAlert.innerHTML = message;

    var alertElement = document.createElement('div');
    alertElement.className = 'alert alert-warning';
    alertElement.innerHTML = '<a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div>';

    flashMessages.innerHTML = '';
    flashMessages.appendChild(alertElement);

    setTimeout(function() {
      alertElement.style.display = 'none';
    }, 5000);

    return false;
  };
});