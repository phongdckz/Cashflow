# Cashflow

Cashflow is a lightweight personal expense management app designed to help track spending, monitor recurring costs, and keep an eye on monthly cash flow without the complexity of a full-featured finance platform.

The project is intentionally simple and focused on usability, making it a good fit for personal budgeting, small-scale household tracking, or day-to-day expense logging.

## Overview

This app is built with a minimal web stack:

- Vanilla HTML
- CSS for layout and styling
- JavaScript for client-side interaction
- HTMX optionally used for lightweight dynamic updates
- Cloudflare stack for hosting, serverless functions, and data persistence

The goal is to create a fast, low-maintenance expense tracker that is easy to use on desktop and mobile while still being deployable with modern Cloudflare infrastructure.

## Features

- Add and categorize expenses
- Track income and outgoing payments
- View totals by category or date range
- Monitor monthly spending trends
- Simple dashboard for quick insight into cash flow
- Lightweight, dependency-minimal frontend
- Personal-first design without complicated authentication or enterprise features

## Tech Stack

### Frontend
- HTML
- CSS
- JavaScript
- Optional HTMX for server-driven UI updates

### Backend / Infrastructure
- Cloudflare Pages for static frontend hosting
- Cloudflare Workers for API endpoints and business logic
- Cloudflare D1 or KV storage for local data persistence (depending on implementation)
- Wrangler for local development and deployment

## Intended Use

This project is best suited for:

- Personal budgeting
- Tracking everyday purchases
- Reviewing spending habits over time
- Experimenting with a simple Cloudflare-hosted web app

## Deployment

The project is intended to be deployed using Cloudflare services, commonly by:

- Hosting the frontend on Cloudflare Pages
- Serving APIs through Cloudflare Workers
- Persisting data with D1 or KV depending on the selected data model

## Notes

This is a personal project and prioritizes simplicity, clarity, and maintainability over advanced financial features. It is a good example of a lightweight app architecture that still takes advantage of Cloudflare's serverless ecosystem.

## License

This project is currently intended for personal use and can be adapted for your own workflow or portfolio purposes.
