# discuss² - a modern, open-source community platform.

[![Ruby Version](https://img.shields.io/badge/ruby-3.3.6-brightgreen.svg)](https://www.ruby-lang.org/)
[![Rails Version](https://img.shields.io/badge/rails-8.0.2-brightgreen.svg)](https://rubyonrails.org/)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A modern, lightweight forum platform built with Ruby on Rails. discuss² provides all the essential features for building thriving online communities with a clean, responsive interface.

## Table of Contents

- [Live Demo](#live-demo)
- [Features](#features)
  - [Core Forum Features](#core-forum-features)
  - [User Features](#user-features)
  - [Admin & Moderation](#admin--moderation)
  - [Technical Features](#technical-features)
- [Quick Start](#quick-start)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Development](#development)
  - [Running Tests](#running-tests)
  - [Code Quality](#code-quality)
  - [Database Operations](#database-operations)
  - [Credentials Configuration](#credentials-configuration)
- [Architecture](#architecture)
  - [Technology Stack](#technology-stack)
  - [Key Components](#key-components)
- [Deployment](#deployment)
	- [Prerequisites](#prerequisites)
  - [Configuration Files](#configuration-files)
  - [Deployment Commands](#deployment-commands)
  - [Monitoring](#monitoring)
- [Testing](#testing)
- [Contributing](#contributing)
- [Roadmap](#roadmap)
- [Bug Reports](#bug-reports)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Live Demo

Check out the live demo of discuss² at [https://discuss2.com/](https://discuss2.com/).

## Features

### Core Forum Features
- **Modern, Minimal UI**: A user-friendly layout that gets out of the way and lets conversations shine.
- **Built for Communities**: discussions, categories, tags, mentions, moderation tools - everything you need to foster meaningful engagement.
- **Fast & Flexible**: Lightweight, responsive, and easy to customize. discuss² is made for both speed and extensibility.
- **Open Source & Self-Hostable**: Fully open source under the MIT license. Run it on your own server, modify it freely, and make it your own.

### User Features
- **User Profiles**: Customizable profiles with avatar support
- **Role System**: Admin, Moderator, and Forum User roles
- **OAuth Integration**: Google OAuth2 authentication
- **Email Notifications**: Powered by Devise
- **SEO Friendly**: Friendly URLs and meta tags

### Admin & Moderation
- **Content Moderation**: Edit, delete, and manage posts and topics
- **Spam Protection**: Invisible captcha integration

### Technical Features
- **Modern Rails 8**: Built on the latest Rails framework
- **Component Architecture**: ViewComponent for reusable UI elements
- **Real-time Updates**: Turbo and Stimulus for dynamic interactions
- **Docker Ready**: Containerized deployment with Kamal

## Quick Start

### Prerequisites

| Technology | Version |
|------------|----------|
| [Ruby](https://www.ruby-lang.org) | 3.3.6 |
| [Ruby on Rails](http://www.rubyonrails.org/) | 8.0.2 |
| [SQLite](https://www.sqlite.org/) | 3.0+ |

### Installation

1. **Clone the repository**
   ```bash
   git clone git@github.com:atenbi/discuss2.git
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup the database**
   ```bash
   rails db:setup
   rails db:migrate
   ```

4. **Install JavaScript dependencies**
   ```bash
   bin/importmap install
   ```

5. **Run forum seeds rake task (optional)**
	```bash
	rails db:seed_forum
	```

6. **Start the development server**
   ```bash
   bin/dev
   ```

7. **Visit the application**
   Open [http://localhost:3000](http://localhost:3000) in your browser

## Development

### Running Tests

```bash
# Run the full test suite
bundle exec rspec

# Run specific test types
bundle exec rspec spec/models
bundle exec rspec spec/features
bundle exec rspec spec/requests
```

### Code Quality

```bash
# Run RuboCop for code style
bundle exec rubocop

# Run Brakeman for security analysis
bundle exec brakeman
```

### Database Operations

```bash
# Create and seed the database
rails db:create db:migrate db:seed

# Reset the database
rails db:reset
```

### Credentials Configuration

You can optionally configure additional credentials for your instance by editing the Rails credentials files:

```bash
# Edit local credentials
bin/rails credentials:edit

# Edit staging credentials
bin/rails credentials:edit --environment staging

# Edit production credentials  
bin/rails credentials:edit --environment production
```

These credentials can include keys for services like:
- `google_tag_id` - Google Analytics tracking
- `google_oauth2` - OAuth authentication
- `smtp` - Email configuration
- `cloudflare` - CDN and storage
- `kamal_registry_password` - Docker registry access
- `rails_master_key` - Rails encryption key

## Architecture

### Technology Stack

- **Backend**: Ruby on Rails 8.0.2
- **Frontend**: Turbo, Stimulus, Tailwind CSS
- **Database**: SQLite
- **Authentication**: Devise with OAuth2
- **Authorization**: Pundit policies
- **UI Components**: ViewComponent
- **Styling**: Tailwind CSS
- **Deployment**: Kamal

### Key Components

- **Forum Models**: `Forum::Topic`, `Forum::Post`, `Forum::Category`, `Forum::Tag`
- **User System**: Devise-based authentication with role management
- **Component Library**: Reusable ViewComponents in `app/components/`
- **Services**: Business logic in `app/services/forum/`
- **Policies**: Authorization rules in `app/policies/`

## Deployment

This project is configured for deployment using [Kamal](https://kamal-deploy.org/), a modern deployment tool that packages your Rails app into Docker containers and deploys them to any VPS.

#### Prerequisites
- A Virtual Private Server (VPS)
- Docker installed on your deployment server
- Domain name configured to point to your server

#### Configuration Files

The project includes example deployment files that you can customize:

- `config/deploy.example.yml` - Production deployment template
- `config/deploy.staging.example.yml` - Staging deployment template
- `.kamal/secrets` - Production secrets (encrypted)
- `.kamal/secrets.staging` - Staging secrets (encrypted)

To set up your deployment configuration:

```bash
# Copy example deployment files
cp config/deploy.example.yml config/deploy.yml
cp config/deploy.staging.example.yml config/deploy.staging.yml

# Then edit with your actual server details
```

#### Deployment Commands

```bash
# Initial setup
kamal setup

# Deploy to production
kamal deploy

# Deploy to staging
kamal deploy --destination staging

# Check deployment status
kamal app logs

# Access Rails console on production
kamal app exec --interactive "bin/rails console"
```

#### Monitoring

```bash
# View application logs
kamal app logs --follow

# Check container status
kamal app details
```

For detailed configuration options and troubleshooting, refer to the [official Kamal documentation](https://kamal-deploy.org/).

## Testing

The application includes comprehensive test coverage:

- **Model Specs**: Validations, associations, and business logic
- **Feature Specs**: End-to-end user workflows with Capybara
- **Request Specs**: API endpoints and controller actions
- **Component Specs**: ViewComponent rendering and behavior
- **Service Specs**: Business logic and data operations

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass (`bundle exec rspec`)
6. Run code quality checks (`bundle exec rubocop`)
7. Commit your changes (`git commit -m 'Add amazing feature'`)
8. Push to the branch (`git push origin feature/amazing-feature`)
9. Open a Pull Request

### Development Guidelines

- Follow the existing code style and conventions
- Write tests for new features and bug fixes
- Update documentation as needed
- Ensure CI passes before submitting PRs

## Roadmap
- Plugin and extension support
- Richer notifications (email, in-app)
- Webhooks & API enhancements
- Mobile-optimized UI improvements
- Admin panel with advance moderation tools

## Bug Reports

Please use the [GitHub Issues](https://github.com/atenbi/discuss2/issues) to:

- Report bugs
- Request new features
- Ask questions about usage
- Discuss potential improvements

When reporting bugs, please include:
- Steps to reproduce
- Expected vs actual behavior
- Error messages (if any)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [Ruby on Rails](https://rubyonrails.org/)
- UI powered by [Tailwind CSS](https://tailwindcss.com/)
- Authentication via [Devise](https://github.com/heartcombo/devise)
- Components with [ViewComponent](https://viewcomponent.org/)
- Deployment with [Kamal](https://kamal-deploy.org/)

---

**discuss²** - Building better communities, one conversation at a time.
