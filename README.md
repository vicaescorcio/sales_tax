# Ruby Sales Tax Project

Ruby project to apply taxes over purchased products

## Prerequisites

Make sure you have the following installed:

- **Ruby** (version `>= 2.7.0`)
- **Bundler** (version `>= 2.0`)

You can check your installed versions with:

```bash
ruby -v
bundler -v
```

## Project Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/username/project-name.git
   cd project-name
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

## Project Structure

```
project-name/
├── lib/             # Main project code
├── spec/            # Project tests
│   └── spec_helper.rb  # RSpec configuration
├── Gemfile          # Dependency file
├── Gemfile.lock     # Locked dependency versions
└── README.md        # Project documentation
```

## Running Tests

This project uses **RSpec** for testing. To run all tests, execute:

```bash
bundle exec rspec
```

To run a specific test file:

```bash
bundle exec rspec spec/test_name_spec.rb
```

## Run the app

If you are in the project directory


```bash
 ./lib/tax_sale.rb purchases.txt
```

- The output will be write in `taxed_sale_output.txt` file
