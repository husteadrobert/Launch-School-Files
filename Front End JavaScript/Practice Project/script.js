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
  /*
  bind: function() {
    $('.container').on('click', 'a', this.clickEvent.bind(this));
  },
  */
  init: function() {
    //this.bind();
    this.compileTemplates();
    return this;
  },
  /*
  clickEvent: function(e) {
    e.preventDefault();
    var $contacts = $('.singleContact');
    var $el = $(e.target);
    var id = parseInt($el.closest('div').attr('data-id'), 10);
    if ($el.attr('data-method') === 'delete') {
      this.deleteContact(id);
    } else if ($el.attr('data-method') === 'edit') {
      this.editContact(id)
    }
    //console.log($contacts.index($el.closest('div')) + $el.attr("data-method"));
    //console.log($el.closest('div').attr('data-id') + $el.attr('data-method'));
  },
  */
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
  editContact: function(id) {
    console.log('edit');
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
    var id = parseInt($(e.target).closest('div').attr('data-id'));
    list.deleteContact(id);
    updateDisplay(list);
  });

  $('main').on('submit', 'form', function(e) {
    e.preventDefault();
    //Check Data-method, then use list.editContact(data) or list.addToContacts(data)
    var data = $(this).serializeArray();
    list.addToContacts(data);
    updateDisplay(list);
    this.reset();
    showMainMenu();
  });

});

function showMainMenu() {
  var $visiblePanel = $('main div:visible');
  var $toMove = $('.container').detach();
  $('main').append($toMove);
  $('.container').slideDown(300);
  $visiblePanel.slideUp(300);
}

function showNewMenu(list) {
  //var $toMove = $('#createContact').detach();
  //$('main').append($toMove);
  //$('.container').slideUp(300);
  //$('#createContact').slideDown(300);
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

  //var $toMove = $('#editContact').detach();
  //$('main').append($toMove);
  //$('.container').slideUp(300);
  //$('#editContact').slideDown(300);
  var info = list.getSingleContact(id);
  info.title = "Edit";
  info.method = "edit";
  var $toMove = $('.forms').html(list.templates.form(info));
  $('main').append($toMove);
  $('.container').slideUp(300);
  $('.forms').slideDown(300);
}

function updateDisplay(list) {
  var $container = $('.container');
  $container.html(list.templates.contacts({contacts: list.contacts}));
}

//Checking Form
//Cancel vs. Submit
//Edit Form
//Tag System
//Can use template for Edit/New Contact
//Use function with :visible to show main menu on 'cancel'
//Dont' need click events in object
//Initial slide down on load
//REmove displaylist from Contacts.