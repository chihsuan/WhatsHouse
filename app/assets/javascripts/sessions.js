$(document).ready(function(){
  $('#signin').form({       
    email: {
      identifier: "session[email]",
      rules: [{
        type: 'empty',
        prompt: 'Please enter your email'
      },{
        type: 'email',
        prompt: 'Please enter a valid email'
      }]
    },       
    password: {
      identifier: "session[password]",
      rules: [{
        type: 'empty',
        prompt: 'Please enter a password'
      },{
        type: 'length[6]',
        prompt: 'Password needs to be atleast 6 characters long'
      }]
    }
  }, {
    on: 'blur',
    inline: 'true',
    onSuccess : function() {
    }
  });

    $('#signup').form({       
    name: {
      identifier: "user[name]",
      rules: [{
        type: 'empty',
        prompt: 'Please enter your email'
      }]
    },
    email: {
      identifier: "user[email]",
      rules: [{
        type: 'empty',
        prompt: 'Please enter your email'
      },{
        type: 'email',
        prompt: 'Please enter a valid email'
      }]
    },       
    password: {
      identifier: "user[password]",
      rules: [{
        type: 'empty',
        prompt: 'Please enter a password'
      },{
        type: 'length[6]',
        prompt: 'Password needs to be atleast 6 characters long'
      }]
    },
    password_confirmation: {
      identifier: "user[password_confirmation]",
      rules: [{
        type: 'empty',
        prompt: 'Please enter the password again'
      },{
        type: 'length[6]',
        prompt: 'Password needs to be atleast 6 characters long'
      }]
    }
  }, {
    on: 'blur',
    inline: 'true',
    onSuccess : function() { 
      alert("yes");     
    }
  });
});
