// structural_design_pattern/composite/examples/composite_form_example.dart
/// https://refactoring.guru/design-patterns/composite/php/example#example-1
/// Composite is a structural design pattern that lets you compose objects into tree structures and then work with these structures as if they were individual objects.
/// Composite became a pretty popular solution for the most problems that require building a tree structure. Composite’s great feature is the ability to run methods recursively over the whole tree structure and sum up the results.
///
/// Usage examples: The Composite pattern is commonly used when working with object trees.
/// The simplest example would be applying the pattern to elements of the DOM tree, working with the composite and simple elements of the tree in the same way.
///
/// Identification:
/// If you have an object tree, and each object of a tree is a part of the same class hierarchy, this is most likely a composite.
/// If methods of these classes delegate the work to child objects of the tree and do it via the base class/interface of the hierarchy, this is definitely a composite.
///
/// The Composite pattern can streamline the work with any tree-like recursive structures.
/// The HTML DOM tree is an example of such a structure.
/// For instance, while the various input elements can act as leaves, the complex elements like forms and fieldsets play the role of composites.
///
/// Bearing that in mind, you can use the Composite pattern to apply various behaviors to the whole DOM tree in the same way as to its inner elements without coupling your code to concrete classes of the DOM tree.
/// Examples of such behaviors might be rendering the DOM elements, exporting it into various formats, validating its parts, etc.
/// With the Composite pattern, you don’t need to check whether it’s the simple or complex type of element before executing the behavior.
/// Depending on the element’s type, it either gets executed right away or passed all the way down to all element’s children.
library;

/// The base Component class declares an interface for all concrete components,
/// both simple and complex.
///
/// In our example, we'll be focusing on the rendering behavior of DOM elements.
abstract class FormElement {
  final String name;
  final String title;
  dynamic _data;

  FormElement(this.name, this.title);

  String getName() => name;

  void setData(dynamic data) {
    _data = data;
  }

  dynamic getData() => _data;

  /// Each concrete DOM element must provide its rendering implementation, but
  /// we can safely assume that all of them are returning strings.
  String render();
}

/// This is a Leaf component. Like all the Leaves, it can't have any children.
class Input extends FormElement {
  final String type;

  Input(super.name, super.title, this.type);

  /// Since Leaf components don't have any children that may handle the bulk of
  /// the work for them, usually it is the Leaves who do the most of the heavy-
  /// lifting within the Composite pattern.
  @override
  String render() {
    final value = _data ?? '';
    return '<label for="$name">$title</label>\n'
        '<input name="$name" type="$type" value="$value">\n';
  }
}

/// The base Composite class implements the infrastructure for managing child
/// objects, reused by all Concrete Composites.
abstract class FieldComposite extends FormElement {
  /// The collection of child elements.
  final Map<String, FormElement> fields = {};

  FieldComposite(super.name, super.title);

  /// The methods for adding/removing sub-objects.
  void add(FormElement field) {
    fields[field.name] = field;
  }

  void remove(FormElement component) {
    fields.remove(component.name);
  }

  /// Whereas a Leaf's method just does the job, the Composite's method almost
  /// always has to take its sub-objects into account.
  ///
  /// In this case, the composite can accept structured data.
  @override
  void setData(dynamic data) {
    if (data is Map<String, dynamic>) {
      fields.forEach((name, field) {
        if (data.containsKey(name)) {
          field.setData(data[name]);
        }
      });
    }
  }

  /// The same logic applies to the getter. It returns the structured data of
  /// the composite itself (if any) and all the children data.
  @override
  dynamic getData() {
    final Map<String, dynamic> data = {};
    fields.forEach((name, field) {
      data[name] = field.getData();
    });
    return data;
  }

  /// The base implementation of the Composite's rendering simply combines
  /// results of all children. Concrete Composites will be able to reuse this
  /// implementation in their real rendering implementations.
  @override
  String render() {
    var output = '';
    fields.forEach((name, field) {
      output += field.render();
    });
    return output;
  }
}

/// The fieldset element is a Concrete Composite.
class Fieldset extends FieldComposite {
  Fieldset(super.name, super.title);

  @override
  String render() {
    // Note how the combined rendering result of children is incorporated
    // into the fieldset tag.
    final output = super.render();
    return '<fieldset><legend>$title</legend>\n$output</fieldset>\n';
  }
}

/// And so is the form element.
class Form extends FieldComposite {
  final String url;

  Form(super.name, super.title, this.url);

  @override
  String render() {
    final output = super.render();
    return '<form action="$url">\n<h3>$title</h3>\n$output</form>\n';
  }
}

/// The client code gets a convenient interface for building complex tree
/// structures.
FormElement getProductForm() {
  final form = Form('product', 'Add product', '/product/add');
  form.add(Input('name', 'Name', 'text'));
  form.add(Input('description', 'Description', 'text'));

  final picture = Fieldset('photo', 'Product photo');
  picture.add(Input('caption', 'Caption', 'text'));
  picture.add(Input('image', 'Image', 'file'));
  form.add(picture);

  return form;
}

/// The form structure can be filled with data from various sources. The Client
/// doesn't have to traverse through all form fields to assign data to various
/// fields since the form itself can handle that.
void loadProductData(FormElement form) {
  final data = {
    'name': 'Apple MacBook',
    'description': 'A decent laptop.',
    'photo': {
      'caption': 'Front photo.',
      'image': 'photo1.png',
    },
  };

  form.setData(data);
}

/// The client code can work with form elements using the abstract interface.
/// This way, it doesn't matter whether the client works with a simple component
/// or a complex composite tree.
void renderProduct(FormElement form) {
  print(form.render());
}

void main() {
  final form = getProductForm();
  loadProductData(form);
  renderProduct(form);
}



///  Output.txt: Execution result
/// 
/// <form action="/product/add">
/// <h3>Add product</h3>
/// <label for="name">Name</label>
/// <input name="name" type="text" value="Apple MacBook">
/// <label for="description">Description</label>
/// <input name="description" type="text" value="A decent laptop.">
/// <fieldset><legend>Product photo</legend>
/// <label for="caption">Caption</label>
/// <input name="caption" type="text" value="Front photo.">
/// <label for="image">Image</label>
/// <input name="image" type="file" value="photo1.png">
/// </fieldset>
/// </form>