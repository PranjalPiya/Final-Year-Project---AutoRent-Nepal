// Here we validated text of every textfield.

class TextFieldValidator {
  //user name validation
  static usernamneValidation(value) {
    if (value!.isEmpty) {
      return 'Please provide your Username.';
    }
    return null;
  }

  // Email Validation
  static emailValidation(value) {
    if (value!.isEmpty) {
      return 'Please enter your Email Address.';
    }
    // using regular expression
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  //ADDRESS validation
  static addressValidation(value) {
    if (value!.isEmpty) {
      return 'Please provide your Address.';
    }
    return null;
  }

  // Full Name
  static fullNameValidation(value) {
    if (value!.isEmpty) {
      return 'Please enter your Full Name';
    }
    return null;
  }

  //Phone Number Validation
  static phoneNumberValidation(value) {
    if (value!.isEmpty) {
      return 'Please enter your Phone Number';
    } else if (value.length < 10) {
      return 'Your Phone Number should be of 10 digits';
    } else if (value.length > 10) {
      return 'Your number should not exceed more than 10 digits';
    }

    return null;
  }

  //Password Validation
  static passwordValidation(value) {
    if (value!.isEmpty) {
      return 'Please enter your Password';
    } else if (value.length < 4) {
      return 'Your password should be atleast 4 character.';
    }
    return null;
  }

  //Feedback validation
  static feedbackValidation(value) {
    if (value!.isEmpty) {
      return 'Please provide your Feedback.';
    }
    return null;
  }
}
