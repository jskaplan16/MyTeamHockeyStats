# HockeyStats Project - Organized Structure

This is the reorganized version of the MyTeamHockeyStats.com ColdFusion application.

## Project Structure

```
HockeyStatsProject/
├── Application.cfc          # Main application configuration
├── index.cfm               # Homepage/landing page
├── web.config              # IIS configuration
├── robots.txt              # SEO robots file
├── crossdomain.xml         # Cross-domain policy
│
├── app/                    # Application logic
│   ├── pages/             # Main application pages
│   │   ├── Games.cfm      # Games management
│   │   ├── Roster.cfm     # Team roster
│   │   ├── Stats.cfm      # Statistics display
│   │   ├── Reports.cfm    # Coach reports
│   │   ├── Admin.cfm      # Admin panel
│   │   ├── PlayerDetail.cfm
│   │   ├── authenticate.cfm
│   │   ├── LoginPage.cfm
│   │   ├── SignUpPage.cfm
│   │   ├── Logout.cfm
│   │   └── myaccount.cfm
│   │
│   ├── actions/           # Server-side processing
│   │   ├── Action*.cfm    # Action handlers
│   │   └── Save*.cfm      # Save operations
│   │
│   ├── displays/          # Display components
│   │   └── Display*.cfm   # Display templates
│   │
│   └── forms/            # Form components
│       └── Form*.cfm     # Form templates
│
├── includes/              # Reusable components
│   ├── headers/           # Header templates
│   │   ├── Header.cfm
│   │   └── BaseHeader.cfm
│   ├── footers/           # Footer templates
│   │   └── Footer.cfm
│   └── components/        # Other components
│       └── PageWrapper.cfm
│
├── assets/                # Static assets
│   ├── css/              # Stylesheets
│   │   ├── *.css        # Main CSS files
│   │   └── CSS/         # Additional CSS
│   ├── js/               # JavaScript files
│   │   └── *.js         # JS scripts
│   ├── images/           # Images and icons
│   │   ├── favicon.ico
│   │   ├── HockeyIcons/ # Hockey-related icons
│   │   └── CSS/         # CSS images
│   └── icons/            # Additional icons
│
├── data/                  # Data-related files
│   ├── games/            # Game data
│   ├── rosters/          # Roster data
│   ├── teams/            # Team data
│   ├── players/          # Player data
│   ├── GameSheets/       # Game sheet templates
│   └── HockeyStats/      # Statistics data
│
├── admin/                 # Administrative tools
│   ├── tools/            # Admin tools
│   └── reports/         # Admin reports
│
├── models/               # Data models
│   └── *.cfc            # ColdFusion components
│
├── Scripts/              # Additional scripts
├── WEB-INF/             # Web application configuration
└── README.md            # This file
```

## Key Features

- **Hockey Statistics Management**: Track games, goals, assists, penalties, plus/minus
- **Team Management**: Manage rosters, players, and team information
- **User Authentication**: Login/signup system with role-based access
- **Reporting**: Coach tools and administrative reports
- **Responsive Design**: Mobile-friendly interface

## Technology Stack

- **Backend**: ColdFusion 2023
- **Database**: SQL Server (HockeyStats datasource)
- **Frontend**: HTML, CSS, JavaScript
- **Server**: IIS with ColdFusion integration

## Setup Instructions

1. **Create Virtual Directory**: Set up a virtual directory in IIS pointing to this folder
2. **Database Connection**: Ensure the HockeyStats datasource is configured in ColdFusion Administrator
3. **File Permissions**: Set appropriate read/write permissions for the web server
4. **Path Updates**: Update any hardcoded paths in the application files if needed

## Virtual Directory Configuration

To set up a virtual directory in IIS:

1. Open IIS Manager
2. Right-click on your website
3. Select "Add Virtual Directory"
4. Set alias: `hockeystats` (or your preferred name)
5. Set physical path to this HockeyStatsProject folder
6. Ensure ColdFusion is configured to handle .cfm files in this directory

## Notes

- The original files have been organized by functionality for better maintainability
- All core application files are preserved
- The structure follows ColdFusion best practices
- Database connections and configurations remain unchanged

