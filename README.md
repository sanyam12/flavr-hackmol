
# ![flavr (1)](https://github.com/mridul549/FlavR-Backend/assets/94969636/98f80461-cf23-4e8b-b6d2-3a6a435c434e)


This food ordering project is a comprehensive solution that facilitates a seamless ordering process for users while providing efficient management tools for outlet owners. The project consists of two distinct apps developed using Flutter: a user app and an owner app.

The user app allows customers to conveniently browse and select food items from local food outlets. Once the order is placed, users are seamlessly redirected to a secure payment gateway to complete the transaction. This ensures a smooth and secure payment process. After successful payment, the order details are automatically forwarded to the respective outlet for confirmation.

Upon confirmation by the outlet, an order number is assigned, and users are notified through the app. This eliminates the need for users to physically visit the outlet or repeatedly inquire about the status of their order. Users can simply wait for the notification and then proceed to the food outlet for order collection.

On the other hand, the owner app provides outlet owners with powerful tools to efficiently manage their operations. Owners can view and process incoming orders, keeping track of order details, delivery preferences, and customer information. The app also facilitates seamless communication with users, enabling owners to provide updates or address any concerns regarding the order.

To further enhance outlet management, a dedicated website using React.js has been developed specifically for owners. This website serves as a comprehensive outlet management system, allowing owners to perform CRUD operations on their menu and outlet(s), and monitor the incoming orders. It also provides the owner with various analytics about their outlet like revenue generated, various outlets comparison and products ordering frequency. The website also provides a user-friendly interface and can be easily accessed from larger screens, making it ideal for use in the outlet's kitchen.

The backend of the project is built using Node.js, Express, MongoDB, Redis, and Firebase. These technologies ensure efficient data management, real-time notifications, and seamless integration between the user app, owner app, and the website.

Overall, this project revolutionizes the food ordering experience by providing a convenient and streamlined solution for users while empowering outlet owners with efficient management tools. It enhances customer satisfaction, reduces waiting times, and increases operational efficiency for food outlets.


## Key Features

- User-Friendly Ordering
- Real time management of orders by the outlet
- Secure Payment Gateway
- Cross platform functionality
- Various Analytics tools available
- User app, Owner app, and Website work together in sync


## Tech Stack

**Website:** ReactJS, Context API, and Bootstrap.

**User and Owner App:** Flutter, Firebase, and Bloc.

**Server:** NodeJS, Express, MongoDB, Redis and Firebase.


# Description of the Apps

This section describes in detail the working of the User app, the owner app, and the Website (All three of these are still in development phase, so there might be some bugs).

## The User app
The user app can be used by the users to place orders on the food outlet of their choice. The App is developed using Flutter and Bloc Technology.

#### Key Features

* **User Registration and Authentication:** Seamless registration process and secure user authentication to create and access personal accounts.
* **Browse Menus:** Users can easily browse and explore the menus of local food outlets, displaying various food items and their details.
* **Place Orders:** Conveniently place food orders from selected outlets, customizing quantities and preferences.
* **Secure Payments:** Integrated payment gateway for safe and hassle-free transactions while placing orders.
* **Order Tracking:** Real-time updates on order status, including confirmation, preparation, and delivery progress.
* **Order History:** Access to previous order details, making it easy for users to reorder their favorite items.
* **Notifications:** Automatic notifications to keep users informed about order updates.

#### Demo

* Selecting the outlet
* Placing an order
* Real-time order updates
* Order History

## The Website
The website developed as part of the food ordering project serves as a comprehensive outlet management system for owners. Built using **React.js**, the website offers a user-friendly interface and a range of features that facilitate efficient management of the outlet's operations.

#### Links
* APK https://drive.google.com/file/d/1r3zALL1ghti6G4Kuf1EKPUbXFQCmP1Bt/view?usp=sharing
* Repo https://github.com/mridul549/ownerweb
* Website live at https://flavr.onrender.com/

#### Key features 

* **Outlet Menu Management:** The website enables owners to perform CRUD operations on the menu. They can easily add, update, and delete food items, ensuring that the menu is always up to date and reflects the available options.

* **Outlet Information:** Owners can update important information about their outlet, such as contact details, address, working hours

* **Order Tracking:** The website provides a centralized platform for owners to track and manage incoming orders. Owners can view details of each order, including the items ordered, delivery preferences, and customer information.

* **Real-Time Notifications:** The website offers real-time notifications to owners, keeping them informed about new orders.

* **Analytics and Reporting:** The website includes analytics features that provide owners with valuable insights into their business. They can access data on popular menu items, sales performance, and different outlets comparison (the ones they own).

## Documentation

The Documentation of the REST-API can be found [here](https://documenter.getpostman.com/view/21883208/2s93m4ZPc1). This Documentation was created with the help of **Postman**.



## Contributing

Contributions are always welcome!

See `contributing.md` for ways to get started.

Please adhere to this project's `code of conduct`.

### Current Contributors

| Developed                                | Contributors             |
|------------------------------------------|--------------------------|
| The User and the Owner app using Flutter | @sanyam12 and @Akshi-ta  |
| The Website using ReactJS                | @mridul549 and @chahat30 |
| The Server using Nodejs                  | @mridul549               |


## FAQ

#### Q- In the user app, when multiple people place orders simultaneously, how does the system allocate unique order numbers to ensure accurate tracking and management of each order?

**A-** To handle concurrent order placements, we have implemented a queue-based system that assigns order numbers to incoming orders in a sequential manner. By using queues, we ensure that each order is processed one by one, eliminating any potential race conditions that may arise when multiple people place orders simultaneously. This was done with the help of [Bull](https://www.npmjs.com/package/bull) package and **Redis**.


#### Q- What service are we using to host the REST API?

**A-** For hosting the REST API, we have opted for Amazon Web Services (AWS) EC2 instances, leveraging their reliable infrastructure to ensure seamless deployment and scalability of the application.

#### Q- How does the authentication process work?
**A-** We are the **JSON Web Tokens (JWT)** to log in a user into the application or the Website. The token is stored securely in the browser or the app and expires after 30 days.

#### Q- How is a user email verified at the time of Signing Up?
**A-** To verify user emails during Sign Up, the project utilizes the Gmail API or Google OAuth2 for sending email verification messages. When a user registers using their email address, the system integrates with the Gmail API or leverages Google OAuth2 to send a verification email to the provided address.

#### Q- What is the need of using three different databases?
**A-** We are using the different databases for the following use cases:
* **MongoDB-** MongoDB serves as the central data repository for the food ordering project, storing information about outlets, products, orders, users, and owners. It enables efficient data retrieval, storage, and management, ensuring smooth operations.

* **Redis-** Redis is currently being used for two main tasks:
    * **Order queue:** The entire order queue is stored in Redis.
    * **Mail queue:** The version of Gmail API we are using to send OTP mails to users has a rate limiter of sending not more than 100 mails/second. To ensure this condition never arises, we are using a mail queue with concurrency set to 80, which means at a time only 80 verification emails can be sent.
    * In the future we are planning to implement **caching** using Redis to reduce API response times even further.

* **Firebase-** We are using Firebase to enable real-time communication between the **server**, Apps, and the website. Real-time communication is mainly required for **Order handling**. At the various stages of the order handling process, real-time notifications are sent to the apps and the website to update their UI accordingly.

#### Q- Which payment gateway are we using and how do refunds work?
**A-** We are currently using the sandbox version of the [**Cashfree**](https://www.cashfree.com/) Payment gateway. The refunds are handled in the following ways:

* If an order is rejected by the outlet, the user is given the option to claim a **coupon** for the same order amount which can be used immediately at the same outlet again (coupon be used only at the outlet from where the order was rejected) only once.

* Or ask for a **refund** which is credited back to the original payment method of the user in T+7 days.

#### Q- How does the Analytics Dashboard work?
**A-** We are using **MongoDB's Aggregation Pipeline** queries to calculate the revenues and the product comparison statistics.

## Launching

Our app is scheduled to be launched at Lovely Professional University (LPU) Jalandhar, where it will be utilized by the Nescafe Food outlet. This real-world deployment will enable us to thoroughly test the app and gather valuable feedback, facilitating further enhancements and scalability for future expansion to additional outlets.
