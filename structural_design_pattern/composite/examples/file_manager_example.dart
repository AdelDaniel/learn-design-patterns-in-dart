// structural_design_pattern/composite/examples/file_manager_example.dart
/// Example:
/// You are tasked with developing a software component to manage a hierarchical file system structure.
/// The goal is to implement the Composite Pattern to seamlessly work with individual files and directories as part of a unified hierarchy.
library;


/// 1. Component
/// In the file system hierarchy example, the Component is represented by the FileSystemComponent interface.
/// This interface defines the common interface for both [leaf] and [composite objects].
/// It declares a method, display(), which all classes in the hierarchy must implement.
/// Abstract class for FileSystemComponent
abstract interface class FileSystemComponent {
  void display();
}

/// The Component serves as the foundation for all objects within the hierarchy.
/// Whether it's file or a directory, they all must adhere to this common interface.

/// 2. Leaf
/// In the context of our file system hierarchy example, Leaf objects are the individual files.
/// These are the objects that do not have any children.
/// Here is an implementation of a leaf object, a file (Concrete class for File):
class File extends FileSystemComponent {
  final String _name;
  final int _size;

  File(String name, int size)
      : _name = name,
        _size = size;

  @override
  void display() {
    print("File: $_name ($_size bytes)");
  }
}

/// Here, File is a leaf object.
/// It implements the FileSystemComponent interface by providing a display method.
/// It contains data specific to files, such as their name and size.

/// 3. Composite
/// In the file system hierarchy example, Composite objects are directories.
/// These are objects that contain other components, including both leaf objects (files) and other composite objects (subdirectories).
/// Here's an implementation of a composite object, a directory (Concrete class for Directory):
class Directory extends FileSystemComponent {
  final String _name;
  final List<FileSystemComponent> _components = [];

  Directory(String name) : _name = name;

  @override
  void display() {
    print("Directory: $_name");
    for (FileSystemComponent component in _components) {
      component.display();
    }
  }

  void addComponent(FileSystemComponent component) {
    _components.add(component);
  }
}

/// Directory acts as a composite object that implements the FileSystemComponent interface and provides its own display method.
/// It maintains a collection (vector) of FileSystemComponent objects to store files and subdirectories.
/// The addComponent method allows adding child components, enabling a hierarchical file system structure.

/// 4. Client
/// The Client code interacts with the components through the Component interface, and it doesn't need to be aware of whether it's working with a leaf or a composite object.
void main(args) {
  // Create leaf objects (files)
  FileSystemComponent file1 = File("document.txt", 1024);
  FileSystemComponent file2 = File("image.jpg", 2048);
  // Create a composite object (directory)
  Directory directory = Directory("My Documents");

  // Add leaf objects to the directory
  directory.addComponent(file1);
  directory.addComponent(file2);
  // Display the directory (including its contents)
  directory.display();
}

/// In this client code, you can see how the client interacts with both leaf (file) and composite (directory) objects uniformly, without needing to know the specific type of each object.


/// Output
/// Directory: My Documents
/// File: document.txt (1024 bytes)
/// File: image.jpg (2048 bytes)
