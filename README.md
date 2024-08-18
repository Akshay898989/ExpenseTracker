# ExpenseTracker

Summary: This expense tracker app allows users to visualize their expenses graphically and manage their expense data through add/edit features and filter options.

How to Build and Run the App:
1. Clone the project from https://github.com/Akshay898989/ExpenseTracker/tree/feature/Dashboard into Xcode.
2. Open the .xcodeproj file from the cloned directory in Xcode.
3. Run the app within Xcode.

Architecture Overview: The application uses a clean architecture to ensure modularity and maintainability:
1. Data Layer:
    * Repository Interface (DashboardExpenseRepository): Defines the contract for data operations such as fetching expenses.
    * Repository Implementation (DashboardExpenseRepositoryImpl): Implements the repository interface and handles data access, including retrieving data from Core Data or other sources.
    
2. Domain Layer:
    * Entities (ExpenseData, TotalExpense, CategoryExpense): Represent the core business objects related to expense data.
    * Use Case (DashboardExpenseUseCase): Contains business logic and interacts with the repository to retrieve and manipulate data. It provides methods to obtain expenses, total expenses, category expenses, and recent transactions.
    
3. Presentation Layer:
    * ViewModel (DashboardExpenseViewModel): Acts as an intermediary between the UI and the Use Case. It exposes data and commands to the UI, such as loading data, updating intervals, and filtering transactions. The ViewModel calls the Use Case to perform business logic and updates the published properties that the UI observes.
    
4. UI Layer:
    * View (Dashboard):
        * Purpose: Displays the dashboard of the expense tracker, including sections for total expenses, category expenses, and recent transactions.
        * State Management: Uses @StateObject to manage the DashboardExpenseViewModel, which provides the data and functionality for the view.
        * Navigation: Wraps the content in a NavigationView and includes a NavigationLink to AddExpenseView, allowing navigation to the screen where new expenses can be added.
        * Conditional Views: Displays different content based on the presence of recent transactions. Shows a "No Data Present" message if no transactions are available.
        * Data Handling: Calls viewModel.loadData() on view appearance to fetch data and updates the view when data changes, such as reloading after adding a new expense.

Core Data Usage:
1. Core Data Manager:
    * Class: CoreDataManager
    * Purpose: Manages the Core Data stack, including the NSPersistentContainer and NSManagedObjectContext. The singleton pattern ensures a single instance of CoreDataManager throughout the application.
    * Components:
        * persistentContainer: Manages the Core Data stack, including the SQLite store file and NSManagedObjectContext.
        * viewContext: Provides access to the managed object context used for interacting with Core Data entities.
        
2. Base Model:
    * Protocol: BaseModel
    * Purpose: Defines common functionality for Core Data entities. Provides methods to save entities, fetch all entities, and fetch entities by UUID.
    * Methods:
        * save(completion:): Saves the current context and handles errors.
        * all<T>(): Fetches all instances of a given NSManagedObject subclass.
        * byUUID(uuid:): Fetches an entity by its UUID.

