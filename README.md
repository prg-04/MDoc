<a name="readme-top"></a>

<div align="center">

  <br/>
  <h1>Doctor Appointment</h1>

</div>

## 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [Schema](#ER-diagram)
  - [🛠 Built With ](#-built-with-)
  - [Tech Stack ](#tech-stack-)
  - [Key Features ](#key-features-)
  - [🚀 Live Demo](#live-demo)
  - [Kanban Board](#kanban)
- [💻 Getting Started ](#-getting-started-)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Run Tests](#run-tests)
  - [👥 Authors ](#-authors-)
- [🔭 Future Features:](#-future-features)
  - [🤝 Contributing ](#-contributing-)
  - [⭐️ Show your support ](#️-show-your-support-)
  - [🙏 Acknowledgments ](#-acknowledgments-)
  - [📝 License ](#-license-)

# MDoc <a name="about-project"></a>

It's an Online Doctor Reservation web application designed to provide users with the ability to reserve, view, and manage doctors and doctor appointment reservation . The system aims to streamline the process of finding and booking doctors from various locations

#### Link to [Frontend Repository](https://github.com/siddghosh108/m-doc)

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Framework</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

### Key Features <a name="key-features"></a>

- User Access: The system allows users to create accounts and log in
- Doctor reservation: hospitals can list their available doctors. Each listing includes details such as doctors name, date, and location.
- Reservation Management: Users can view available doctors  at different locations and make reservations
- Add and delete doctors in including location

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🚀 Live Demo <a name="live-demo"></a>

- <a href="https://capstone-m-doc.onrender.com/">Live Demo Link</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🎬 Kanban Board <a id="kanban"></a>

Link to the [Kanban Board](https://github.com/users/prg-04/projects/5)

All 3 Authors have been contributing to this project from start to finish

## 💻 Getting Started <a name="getting-started"></a>

### Prerequisites

In order to run this project you need:

- Installed Git.
- Installed Ruby on Rails
- Installed PostgreSQL
- Create a local directory that you want to clone the repository.
- Open the command prompt in the created directory.
- On the terminal run this command git clone https://github.com/prg-04/MDoc.git

### Setup

Clone this repository to your desired folder:

```sh
git clone https://github.com/prg-04/MDoc.git
```

```sh
cd MDoc
```

```sh
bundle install
```

```sh
1. Remove config/master.key and config/credentials.yml.enc if they exist.
2. Run `rails secret`.  Copy the key.
3. Run EDITOR="code --wait" bin/rails credentials:edit
4. In the editor that opens, add this:  devise_jwt_secret_key: <the key you copied in step 2>
5. Save the file and close the editor.  New master.key, credentials.yml.enc files will be generated, and the key will be stored in `Rails.application.credentials.devise_jwt_secret_key`.
```

```sh
rails db:create db:migrate db:seed
```

```sh
rails s
```

### Tests

After setup, you ran use the comman below to run RSpec

```sh
bundle install
```

```sh
rspec
```

## 👥 Authors <a name="authors"></a>

Collaborators.

## 👥 Author <a name="authors"></a>

👤 **Siddhartha Ghosh**

- GitHub: [@siddghosh108](https://github.com/siddghosh108)
- LinkedIn: [@siddhartha-ghosh-65902718](https://www.linkedin.com/in/siddhartha-ghosh-65902718/)

👤 **Peter Akhigbe**

- GitHub: [Peter Akhigbe](https://github.com/peter-akhigbe)
- LinkedIn: [Peter Akhigbe](https://www.linkedin.com/in/peter-akhigbe)

👤 **Evans Karanja**

- GitHub: [@githubhandle](https://github.com/prg-04)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/evanson-karanja/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

# 🔭 Future Features:

- Chat
- Video call


## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page]().

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## ⭐️ Show your support <a name="support"></a>

If you liked this project, give it a ⭐️ and kindly send to me an e-mail expressing it, it would make our day and fuel our motivation.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🙏 Acknowledgments <a name="acknowledgements"></a>

Hats off to Murat Korkmaz for designing the awesome template that inspired us to create this project. ✨
Microverse for giving us this chance
The amazing code reviewers for making us improve every day 👍

Original design idea by [Murat Korkmaz on Behance](https://www.behance.net/gallery/26425031/Vespa-Responsive-Redesign).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
