var ContactList = {
  templates: {},
  tags: [{
    tagName: 'Family',
  }, {
    tagName: 'Business',
  },{
    tagName: 'Friends',
  }, {
    tagName: 'Whatever',
  }],
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
    this.contacts = this.loadList() || [];
    this.currentID = this.findLastID();
    return this;
  },
  findLastID: function() {
    if (this.contacts.length === 0) {
      return 0;
    } else {
      var finalContact = this.contacts[this.contacts.length - 1];
      return finalContact.id + 1;
    }
  },
  addToContacts: function(data) {
    var newContact = {};
    var tags = [];
    data.forEach(function(object) {
      if (object.name === 'checkbox') {
        tags.push({tagName: object["value"]});
      } else {
        newContact[object.name] = object["value"];
      }
    });
    newContact.tags = tags;
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
  isEmpty: function() {
    return this.contacts.length === 0;
  },
  allContacts: function() {
    return this.contacts;
  },
  loadList: function() {
    return JSON.parse(localStorage.getItem('contacts'));
  },
  search: function(searchString, searchTags) {
    //Filter by Tags first
    var result = this.contacts.filter(function(object) {
      var splitName = object.name.split(' ')
      var firstName = splitName[0];
      var lastName = splitName.slice(1).join(' ');
      var search = new RegExp(searchString, 'i');
      return firstName.match(search) || lastName.match(search);
    });
    return result;
  },
};

$(function() {
  var list = Object.create(ContactList).init();
  updateDisplay(list);
  $('.container').hide().delay(300).slideDown(300);

  $('.container').on('keyup', 'input[name="search"]', function(e) {
    var searchString = $(this).val();
    if (searchString.length >= 1) {
      displaySearchResults(list.search(searchString, undefined), list);
    } else {
      updateDisplay(list);
    }
  });

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
    if( window.confirm('Are you sure you want to delete this contact?')) {
      var id = parseInt($(e.target).closest('div').attr('data-id'));
      list.deleteContact(id);
      updateDisplay(list);
    } else {
      return;
    }
  });

  $('.container').on('click', '#newContactCopy', function(e) {
    e.preventDefault();
    $('#newContact').trigger('click');
  });

  $('.container').on('click', '#showEditTags', function(e) {
    e.preventDefault();
    showTagsMenu(list);
  });

  $('.forms').on('click', '#addTagsButton', function(e) {
    e.preventDefault();
    $('#editTagsContainer').slideUp(300);
    $('#addNewTagContainer').slideDown(300);
  });

  $('.forms').on('click', 'a', function(e) {
    e.preventDefault();
    var $form = $(this).closest('form');
    if ($(this).attr('id') === 'cancelButton') {
      showMainMenu();
      return;
    }
    
    if ($(this).attr('id') === 'addTagsButton') {
      //showNewTagsMenu(list);
      return;
    }

    var data = $form.serializeArray();
    console.log(data);
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

  $(window).on('unload', function(e) {
    var contacts = list.allContacts();
    localStorage.setItem('contacts', JSON.stringify(contacts));
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
  //$('input[name="search"]').val('');
  $('main').append($toMove);
  $('.container').slideDown(300);
  $visiblePanel.slideUp(300);
  //Set search bar to ""
}

function showNewMenu(list) {
  var tagList = list.tags;
  var info = {
    title: 'Create',
    method: 'new',
    tags: tagList,
  };
  var $toMove = $('.forms').html(list.templates.form(info));
  $('main').append($toMove);
  $('.container').slideUp(300);
  $('.forms').slideDown(300);

}

function showTagsMenu(list) {
  var $toMove = $('.forms').html(list.templates.tagsEdit({tags: list.tags}));
  $('main').append($toMove);
  $('.container').slideUp(300);
  $('.forms').slideDown(300);
}

function showNewTagsMenu(list) {
  var $toMove = $('.forms').html(list.templates.newTag({}));
  $('main').append($toMove);
  $('.container').slideUp(300);
  $('.forms').slideDown(300);
}

function showEditMenu(list, id) {
  var info = list.getSingleContact(id);
  info.title = "Edit";
  info.method = "edit";
  info.id = id;
  info.tags = list.tags;
  //CHECK TAGS here
  var $toMove = $('.forms').html(list.templates.form(info));
  $('main').append($toMove);
  $('.container').slideUp(300);
  $('.forms').slideDown(300);
}

function updateDisplay(list) {
  var $container = $('.container');
  if (list.isEmpty()) {
    $container.html(list.templates.emptyContacts({}));
    $container.find('header').html(list.templates.headerBar({tags: list.tags}));
  } else {
    $container.html(list.templates.contacts({contacts: list.contacts}));
    $container.find('header').html(list.templates.headerBar({tags: list.tags}));
  }
}

function displaySearchResults(resultList, fullList) {
  var $container = $('#contactDisplayArea');
  if (resultList.length === 0) {
    var $searchTerms = $('input[name="search"]').val();
    $container.html(fullList.templates.emptySearch({searchTerm: $searchTerms}));
    $container.find('header').remove();
  } else {
    $container.html(fullList.templates.contacts({contacts: resultList}));
    $container.find('header').remove();
  }
}

//Tag System
//Should give each tag an ID
//Templates out of Object
//Better event delegation with clicks


//in HTML, make editTags a Form and attach data-method="XXX" so it'll be handled by event listener
//Add tagList property to ContactList, which makes a single String by joining