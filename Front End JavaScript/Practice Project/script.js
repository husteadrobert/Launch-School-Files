var ContactList = {
  contacts: [{
    name: 'Robert Hustead',
    phoneNumber: 1234567890,
    email: 'abc@x.com',
    id: 1,
  }, {
    name: 'John Smith',
    phoneNumber: 0987654321,
    email: '123@x.com',
    id: 2,
  }, {
    name: 'Mary Sue',
    phoneNumber: 111222333,
    email: 'name@x.com',
    id: 3,
  }],
  templates: {},
  currentID: 4,
  compileTemplates: function() {
    var tmp = this.templates;
    $("script[type='text/x-handlebars']").each(function() {
      var $tmpl = $(this);
      tmp[$tmpl.attr('id')] = Handlebars.compile($tmpl.html());
    });
    $('[data-type=partial]').each(function() {
      var $partial = $(this);
      Handlebars.registerPartial($partial.attr('id'), $partial.html());
    });
  },
  init: function() {
    this.compileTemplates();
    return this;
  },
  addToContacts: function(data) {
    var newContact = {};
    data.forEach(function(object) {
      newContact[object.name] = object["value"];
    });
    newContact.id = this.currentID;
    this.currentID += 1;
    this.contacts.push(newContact);
  },
  
  deleteContact: function(id) {
    this.contacts = this.contacts.filter(function(object) {
      return object.id !== id;
    });
  },
  editContact: function(id, data) {
    var currentContact = this.getSingleContact(id);
    data.forEach(function(object) {
      currentContact[object.name] = object["value"];
    });
  },
  getSingleContact: function(id) {
    var result = this.contacts.filter(function(object) {
      return object.id === id;
    });
    return result[0];
  },
};

$(function() {
  var list = Object.create(ContactList).init();
  updateDisplay(list);
  $('.container').hide().delay(300).slideDown(300);

  $('.container').on('click', '#newContact', function(e) {
    e.preventDefault();
    showNewMenu(list);
  });

  $('.container').on('click', 'a[data-method="edit"]', function(e) {
    e.preventDefault();
    var id = parseInt($(e.target).closest('div').attr("data-id"), 10);
    showEditMenu(list, id);
  });

    $('.container').on('click', 'a[data-method="delete"]', function(e) {
    e.preventDefault();
    //Alert
    var id = parseInt($(e.target).closest('div').attr('data-id'));
    list.deleteContact(id);
    updateDisplay(list);
  });

  $('.forms').on('click', 'a', function(e) {
    e.preventDefault();
    var $form = $(this).closest('form');
    if ($(this).attr('id') === 'cancelButton') {
      showMainMenu();
      return;
    }
    var data = $form.serializeArray();
    if (isValid(data)) {
      if ($form.attr('data-method') === 'edit') {
        list.editContact(parseInt($form.attr('data-id') ,10), data);
      } else {
        list.addToContacts(data)
      }
      updateDisplay(list);
      $(this).closest('form')[0].reset();
      showMainMenu();
    } else {
      return;
    }
  });

});


function isValid(data) {
  $('.help').each(function() {
    $(this).addClass('invisible');
  });
  var testData = {};
  var passTest = false;
  data.forEach(function(object) {
    testData[object.name] = object["value"];
  });
  passTest = checkName(testData.name);
  $('form dt.name').toggleClass('error', !passTest);
  $('form input[name="name"]').toggleClass('inputError', !passTest);
  $('#nameHelp').toggleClass('invisible', passTest);
  passTest = checkEmail(testData.email);
  $('form dt.email').toggleClass('error', !passTest);
  $('form input[type="email"]').toggleClass('inputError', !passTest);
  $('#emailHelp').toggleClass('invisible', passTest);
  passTest = checkNumber(testData.phoneNumber);
  $('form dt.phone').toggleClass('error', !passTest);
  $('form input[name="phoneNumber"]').toggleClass('inputError', !passTest);
  $('#phoneHelp').toggleClass('invisible', passTest);
  return checkName(testData.name) && checkNumber(testData.phoneNumber) && checkEmail(testData.email);
}

function checkName(name) {
  return name.length >= 1;
}

function checkNumber(number) {
  return number.length >= 7;
}

function checkEmail(email) {
  return email.includes('@');
}

function showMainMenu() {
  var $visiblePanel = $('main div:visible');
  var $toMove = $('.container').detach();
  $('main').append($toMove);
  $('.container').slideDown(300);
  $visiblePanel.slideUp(300);
  //Set search bar to ""
}

function showNewMenu(list) {
  var info = {
    title: 'Create',
    method: 'new',
  };
  var $toMove = $('.forms').html(list.templates.form(info));
  $('main').append($toMove);
  $('.container').slideUp(300);
  $('.forms').slideDown(300);

}

function showEditMenu(list, id) {
  var info = list.getSingleContact(id);
  info.title = "Edit";
  info.method = "edit";
  info.id = id;
  var $toMove = $('.forms').html(list.templates.form(info));
  $('main').append($toMove);
  $('.container').slideUp(300);
  $('.forms').slideDown(300);
}

function updateDisplay(list) {
  var $container = $('.container');
  $container.html(list.templates.contacts({contacts: list.contacts}));
}

//Tag System
//No contacts issues
//Local Storage

//Put in placeholder, .remove(), updateDisplay put it in if empty
//put placeholder inside container div
//Better event delegation with clicks