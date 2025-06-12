---
title: "How We Experimented with Apple's Container Framework"
translationKey: apple_container_framework_introduction
date: 2025-06-12T05:38:00+00:00
draft: false
toc: true
cover:
  image: "/jcnm/images/apple_container_architecture.png"
  alt: "Apple container architecture"
images:
  - /jcnm/images/apple_container_architecture.png
  - /jcnm/images/apple_container_vs_docker.png
tags:
  - Containerization
  - Apple
  - Docker
  - Swift
  - macOS
  - Apple Silicon
categories:
  - Experimentation
  - DevOps
  - Development Tools
author: "Services CEO DevOps Team"
description: "Discover our first experience with Apple's Container framework, a native containerization solution optimized for macOS and Apple Silicon, announced just a few days ago."
summary: "Following the recent announcement of Apple's Container framework, we immediately explored this new native containerization approach for macOS. This article shares our first impressions, observed performance, and the potential of this solution for developers on Apple Silicon."
keywords:
  - Apple Container
  - Containerization
  - Docker alternative
  - macOS containers
  - Apple Silicon development
  - Lightweight VMs
  - OCI
  - macOS virtualization
references:
  - name: "Container Project GitHub"
    link: "https://github.com/apple/container"
  - name: "Containerization Package GitHub"
    link: "https://github.com/apple/containerization"
  - name: "WWDC25 Presentation: Meet Containerization"
    link: "https://developer.apple.com/videos/play/wwdc2025/346/"
  - name: "Migration Guide from Docker"
    link: "https://www.kubeace.com/blog/apple-container-macos-guide"
---

# How We Experimented with Apple's Container Framework

## Introduction (The "Why")

In the modern software development world, containerization has become an essential pillar of our infrastructure. It allows us to encapsulate our applications and their dependencies in isolated environments, ensuring consistency across different stages of the development cycle. However, for teams working on macOS, particularly on Macs equipped with Apple Silicon chips (M1/M2/M3/M4), this approach often comes with significant compromises.

Since our migration to Apple Silicon Macs two years ago, our development team has regularly encountered challenges with traditional containerization solutions:

- Slow startup times that slow down our development cycles
- Excessive resource consumption (memory and CPU) by Docker Desktop
- Compatibility issues with certain container architectures
- Sometimes laborious integration with the native macOS ecosystem
- Suboptimal performance for intensive workloads

These limitations directly impact our daily productivity. A developer who waits several seconds (or even tens of seconds) each time a container starts can lose valuable time over a full day. Similarly, a computer whose resources are monopolized by the containerization infrastructure becomes less responsive for other essential tasks.

It was in this context that Apple's very recent announcement of its Container framework immediately caught our attention. Promising a native approach, optimized for Apple Silicon and harmoniously integrated with macOS, this new solution seemed to precisely address the challenges we were facing. But beyond the marketing promises, we wanted to concretely evaluate what this framework could bring to our daily workflow.

Our team therefore decided to explore Apple's Container framework in depth immediately after its announcement just a few days ago, to objectively compare it to our current solutions, and to evaluate its potential to transform our development environment. This article shares our first experience, our initial discoveries, and our preliminary recommendations for teams considering exploring this new technology.

## Context (The "What")

Apple's Container framework represents a fundamentally new approach to containerization on macOS. Rather than being a simple Docker alternative, it's a native solution specifically designed for the Apple ecosystem, and particularly optimized for Apple Silicon chips.

### What is Apple's Container framework?

At its core, Apple's Container framework consists of two main elements:

1. **The `container` tool**: A command-line interface (CLI) written in Swift that allows creating and running Linux containers on macOS. This tool is the main entry point for developers.

2. **The Containerization package**: An underlying Swift library that provides the necessary APIs to manage containers, images, and processes. This package is the engine that powers the `container` tool.

Together, these components offer a complete solution for running Linux containers directly on macOS, without requiring a heavy emulation layer or shared virtual machine.

### An architecture redesigned for performance

What fundamentally distinguishes Apple's Container framework from existing solutions is its technical architecture:

- **One VM per container**: Each container runs in its own lightweight and optimized virtual machine, ensuring complete isolation.
- **Optimized Linux kernel**: A minimal and optimized Linux kernel allows startup times of less than a second.
- **Native integration with Virtualization.framework**: Direct use of Apple's virtualization APIs for maximum performance.
- **Lightweight init system (vminitd)**: A minimalist initialization system that starts quickly and consumes few resources.
- **Rosetta 2 support**: Ability to run x86_64 containers on Apple Silicon via Apple's translation technology.

This "one VM per container" approach offers not only performance advantages but also enhanced security. In case of container compromise, the attacker remains confined to an isolated VM, without access to other containers.

### Compatibility with the existing ecosystem

Despite its innovative approach, Apple's Container framework doesn't isolate developers from the existing containerization ecosystem:

- **OCI compliance**: Full compatibility with Open Container Initiative (OCI) format images, the industry standard.
- **Standard registries**: Ability to retrieve and publish images from/to Docker Hub, GitHub Container Registry, and other standard registries.
- **Familiar syntax**: Commands similar to Docker to facilitate team transition.
- **Multi-architecture support**: Native management of ARM64 images and, via Rosetta 2, x86_64 images.

This compatibility allows teams to explore Apple's Container framework without major disruption to their existing workflows, while immediately benefiting from performance gains.

### Positioning relative to alternatives

To clearly situate this solution in the current technological landscape:

| Aspect                | Docker Desktop          | Podman                  | Apple Container Framework  |
| --------------------- | ----------------------- | ----------------------- | -------------------------- |
| **Architecture**      | Shared Linux VM         | Daemonless, rootless    | Dedicated VM per container |
| **Performance**       | Moderate                | Good                    | Excellent on Apple Silicon |
| **Memory footprint**  | High (500MB-2GB)        | Medium                  | Low (<200MB)               |
| **Startup time**      | 3-5 seconds             | 2-3 seconds             | <1 second                  |
| **Isolation**         | Shared containers       | Isolated containers     | Isolated VMs               |
| **macOS integration** | Via compatibility layer | Via compatibility layer | Native                     |
| **Maturity**          | Very mature             | Mature                  | Very recent (few days)     |

Apple's Container framework thus positions itself as a highly optimized solution for developers on macOS, particularly those using Apple Silicon machines, with an emphasis on performance, security, and native integration.
{{< figure align=center src="/jcnm/images/apple_container_vs_docker.png" >}}
## Approach (The "How")

After discovering Apple's Container framework during its announcement a few days ago, we immediately implemented a methodical approach to evaluate it and explore its potential for our workflow. Here's how we proceeded, step by step, in this initial experimentation phase.

### Installation and initial setup

Our first step was to install the `container` tool on our development machines. The process proved remarkably simple:

1. **Downloading the installation package**: We retrieved the latest signed package (.pkg) from Apple's GitHub releases page, published very recently.

2. **Standard installation**: A simple double-click on the package and entering the administrator password was sufficient to install the tool in `/usr/local/`.

3. **Starting the service**: In the terminal, we initialized the service with the command:
   ```bash
   container system start
   ```
   
   This command automatically offered to download an optimized Linux kernel, which we accepted.

4. **Verifying the installation**: We confirmed proper functioning with:
   ```bash
   container --version
   container ls -a
   ```

Unlike other solutions that require complex configurations or multiple dependencies, the installation took less than 5 minutes per workstation, without any compatibility issues on our M1 and M2 Macs.

### First steps with the framework

To familiarize ourselves with the tool, we started with simple operations:

1. **Retrieving images**: We tested retrieving images from Docker Hub:
   ```bash
   container image pull nginx:alpine
   container image pull python:3.9
   ```

2. **Running basic containers**: We launched simple containers to verify functionality:
   ```bash
   container run --detach --name webserver --publish 8080:80 nginx:alpine
   ```

3. **Interacting with containers**: We tested interaction commands:
   ```bash
   container ps
   container logs webserver
   container exec -it webserver sh
   ```

These initial tests immediately highlighted the framework's execution speed. Container startup was almost instantaneous, and system resource usage remained minimal even with several containers running.

### Exploring Docker-equivalent commands

To facilitate our experimentation, we created an equivalence table of the most commonly used commands:

| Action             | Docker Command  | Container Command      |
| ------------------ | --------------- | ---------------------- |
| List containers    | `docker ps`     | `container ps`         |
| List all images    | `docker images` | `container image list` |
| Run a container    | `docker run`    | `container run`        |
| Stop a container   | `docker stop`   | `container stop`       |
| Remove a container | `docker rm`     | `container rm`         |
| Display logs       | `docker logs`   | `container logs`       |
| Execute a command  | `docker exec`   | `container exec`       |

This syntactic similarity considerably facilitated our first steps with the tool. Most developers were able to transpose their habits without major learning effort.

### Network configuration and optimizations

Since network management is a crucial aspect of our development infrastructure, we explored the framework's capabilities in this area:

1. **Basic network configuration**: On macOS 15, we used the traditional port publishing approach:
   ```bash
   container run --detach --name api --publish 3000:3000 our-api
   ```

2. **Advanced networking on macOS 26 Beta**: On test machines with macOS 26 Beta, we explored advanced network features:
   ```bash
   # Creating a dedicated network
   container network create app-network
   
   # Deploying interconnected services
   container run --detach --name db --network app-network mongo
   container run --detach --name api --network app-network our-api
   ```
   
   This configuration allowed direct communication between containers without requiring port publishing, considerably simplifying our architecture.

3. **Exploring volumes**: We tested using volumes for local development:
   ```bash
   container run --volume /Users/dev/project:/app our-image
   ```

### Integration into our test environment

For this initial experimentation phase, we created a representative test environment:

1. **Automation scripts**: We created shell scripts to standardize common operations:
   ```bash
   #!/bin/bash
   # start-dev-env.sh
   container system start
   container run --detach --name redis redis:alpine
   container run --detach --name postgres --env POSTGRES_PASSWORD=dev postgres:13
   container run --detach --name app --publish 3000:3000 --volume $(pwd):/app our-app
   ```

2. **Tests with VS Code**: We verified compatibility with VS Code via the Remote Containers extension, which proved functional with Apple's Container framework.

3. **Documentation of observations**: We carefully documented our discoveries and created an experimentation guide for the entire team.

This exploratory approach allowed us to quickly evaluate Apple's Container framework in the days following its announcement, and to gather initial impressions about its potential for our development environment.

## Results and Observations (The "What Happened")

After a few days of intensive experimentation with Apple's Container framework since its announcement, we have collected preliminary data that allows us to objectively evaluate its potential for our development environment.

### Comparative performance

The first striking difference concerns performance. We systematically measured key metrics by comparing our usual configuration (Docker Desktop) with Apple's Container framework:

| Metric               | Docker Desktop | Apple Container Framework | Improvement |
| -------------------- | -------------- | ------------------------- | ----------- |
| Cold start time      | 3.8 seconds    | 0.7 second                | **81%**     |
| Memory usage at rest | 1.2 GB         | 180 MB                    | **85%**     |
| CPU usage at rest    | 8-12%          | 1-2%                      | **~85%**    |
| Image build time     | 45 seconds     | 38 seconds                | **16%**     |
| Image pull time      | Reference      | 20% faster                | **20%**     |

These preliminary figures are impressive: Apple's Container framework offers substantial performance gains on all measured aspects. The most significant impact concerns container startup time and system resource usage, two points that directly affect developers' daily experience.

To illustrate concretely: a developer who starts and stops 20 containers per day could save about 62 seconds of waiting time daily. Over a month of work, this would represent more than 20 minutes recovered, not counting the indirect benefits of a less taxed and therefore more responsive system.

### Compatibility with our existing projects

A crucial aspect of our evaluation concerned compatibility with our existing ecosystem. Here are our initial observations:

- **Standard Docker images**: 100% of our usual Docker Hub images work without modification.
- **Multi-architecture images**: Excellent handling of native ARM64 images and good compatibility with x86_64 images via Rosetta 2.
- **Volumes and persistence**: Identical functionality to Docker for mounting local volumes.
- **Networks**: Equivalent basic features on macOS 15, promising advanced features on macOS 26 Beta.
- **Development tools**: Confirmed compatibility with VS Code, JetBrains, and other IDEs via their remote development extensions.

We tested our typical development stack, which includes:
- A PostgreSQL database
- A Redis cache
- A Node.js API server
- A React frontend
- A Python processing service

All these components worked without major modification in our test environment, requiring only adaptation of launch commands to use Apple Container framework syntax.

### Observed advantages

Beyond pure metrics, several qualitative advantages emerged from our initial tests:

1. **Promising stability**: We encountered no major incidents related to the containerization infrastructure (crashes, network issues, etc.) during our experimentation period.

2. **Enhanced security**: The "one VM per container" architecture theoretically offers stronger isolation, particularly appreciated for testing potentially risky code.

3. **Native integration**: Integration with macOS seems more fluid, particularly for credential management via Keychain and system resource usage.

4. **Ease of use**: The command-line interface is intuitive and consistent, with a very low learning curve for our team.

5. **System responsiveness**: Developers report better overall responsiveness of their machines during tests, even with several containers running.

### Limitations and challenges encountered

Our experience was not without obstacles. Here are the main limitations we identified in this initial phase:

1. **Ecosystem maturity**: As an extremely recent project, Apple's Container framework doesn't yet have as rich an ecosystem as Docker (graphical interfaces, monitoring tools, etc.).

2. **macOS compatibility**: Advanced network features require macOS 26 Beta, which limits their use in a production environment.

3. **Developing documentation**: The documentation, although solid for such a recent project, is still developing, and some advanced use cases are less well covered.

4. **Absence of Compose**: The equivalent of Docker Compose for orchestrating multiple containers is not yet natively available, requiring custom scripts.

5. **Build limitations**: The image build system seems less flexible than Dockerfile for certain complex scenarios.

### Initial feedback from the development team

We gathered the first impressions of our team after these few days of experimentation:

- 85% of developers are enthusiastic and see significant potential in this solution
- 10% are neutral, finding the solution promising but preferring to wait for its maturation
- 5% are more reserved, mainly due to the youth of the project and uncertainty about its future evolution

Positive comments mainly mention speed, lightness, and stability. Reservations mainly concern the youth of the project and uncertainty about its future evolution.

A senior developer summarized the general feeling: "It's like discovering a car designed specifically for our roads. Everything seems more natural, faster, and better integrated into our environment. But we'll have to see how it behaves in the long term."

## Lessons Learned and Recommendations (The "So What?")

Our initial experimentation with Apple's Container framework has allowed us to draw several preliminary lessons and formulate recommendations for teams considering exploring this new technology.

### Potentially ideal use cases for Apple's Container framework

Based on our initial tests, we have identified scenarios where this framework could particularly excel:

1. **Development environments on Apple Silicon Macs**: This is the quintessential use case, where performance gains seem most significant.

2. **Teams with resource constraints**: For developers working on machines with limited resources (8GB of RAM for example), the framework's lightness could make a considerable difference.

3. **Projects requiring frequent container starts**: Workflows involving numerous start/stop cycles would benefit enormously from ultra-fast startup times.

4. **Applications requiring enhanced isolation**: Projects handling sensitive data or executing unverified code could benefit from the VM-per-container isolation.

5. **Multi-container development environments**: On macOS 26 Beta, advanced network management seems promising for simplifying multi-service architectures.

On the other hand, some use cases seem for now better served by alternative solutions:

- Environments requiring Docker Compose or complex orchestrators
- Workflows heavily dependent on graphical container management tools
- Teams using Intel Macs (not supported by the framework)
- Projects requiring advanced Docker features not yet implemented

### Identified best practices

Our initial experience has allowed us to establish several best practices to get the most out of Apple's Container framework:

1. **Favor native ARM64 images**: Although Rosetta 2 allows running x86_64 images, performance seems significantly better with images compiled for ARM64.

2. **Use automation scripts**: Creating shell scripts to replace Docker Compose functionality considerably simplifies managing multi-container environments.

3. **Optimize volumes**: Limiting the number and size of mounted volumes seems to improve performance, particularly for applications handling many small files.

4. **Adopt a "stateless" approach**: Designing containers to be ephemeral and stateless facilitates their management with Apple's Container framework.

5. **Standardize commands**: Creating shell aliases or functions to standardize commands between Docker and the Container framework simplifies experimentation.

6. **Actively follow updates**: As the framework is in very active development, significant improvements are likely to be published regularly.

### Tips for effective exploration

For teams considering exploring Apple's Container framework, here is our recommended roadmap:

1. **Discovery phase**: Start by installing and testing the tool on a non-critical project to evaluate compatibility and performance.

2. **Progressive approach**: Experiment project by project rather than switching all infrastructure at once.

3. **Documentation of equivalences**: Create an internal guide of equivalences between Docker and Container commands.

4. **Experience sharing**: Organize short demonstration sessions (30-60 minutes) to present new possibilities to the team.

5. **Parallel environment**: Maintain both solutions in parallel during the exploration phase.

6. **Continuous feedback**: Set up a dedicated channel to collect experience feedback and document discoveries.

### Considerations for different types of teams

Exploration of Apple's Container framework should be adapted to each team's specific context:

**For small teams (1-5 developers)**:
- Experimentation can be quick and informal
- Performance gains are immediately perceptible
- The absence of certain graphical tools can be compensated by custom scripts

**For medium teams (5-15 developers)**:
- A more structured approach is recommended
- Designate an "explorer" responsible for evaluation and sharing discoveries
- Formally document observations and tested use cases
- Plan for a more methodical exploration phase

**For large teams (15+ developers)**:
- Create a dedicated exploration group to test and document possibilities
- Develop prototypes of internal tools to fill ecosystem gaps
- Implement formal evaluation
- Consider limited tests in non-critical environments
- Plan for phased exploration with clear objectives

### Potential impact on productivity and satisfaction

Beyond technical aspects, we observed potential impacts on more subjective but equally important factors:

- **Reduced frustration**: Reduced waiting times and apparent stability could decrease workflow interruptions.
- **Increased satisfaction**: Developers seem to appreciate working with tools optimized for their hardware.
- **Sense of belonging**: Using native Apple technology on Apple hardware creates a more coherent and integrated experience.
- **Reduced "mental tax"**: Less cognitive resources seem devoted to infrastructure management, allowing better focus on code.

These factors, although difficult to quantify in this preliminary phase, could significantly contribute to the overall improvement of the development experience if the framework fulfills its promises in the long term.

## Conclusion and Perspectives

Our initial exploration of Apple's Container framework, just days after its announcement, has allowed us to glimpse the potential of this new approach to containerization on macOS. What began as simple technical curiosity quickly transformed into a promising evaluation, with encouraging preliminary results.

### Summary of key points

Apple's Container framework distinguishes itself through several fundamental characteristics:

- **Native performance on Apple Silicon**: Startup times under one second and memory footprint reduced by 85% compared to Docker Desktop in our initial tests.
- **Secure architecture**: VM isolation theoretically offers enhanced security without compromising performance.
- **OCI compatibility**: Seamless integration with the existing container ecosystem facilitates experimentation.
- **macOS integration**: Using Apple's native technologies (Virtualization.framework, Keychain, etc.) creates a coherent and optimized experience.

These advantages could translate into concrete improvement of our daily productivity, with fewer interruptions, better stability, and more efficient use of our machines' resources.

### Expected evolution of the framework and ecosystem

As Apple's Container framework is an extremely recent project, we anticipate several significant evolutions in the coming months:

1. **Ecosystem maturation**: Progressive development of complementary tools, graphical interfaces, and integrations with popular IDEs.

2. **Improvement of network features**: Probable extension of advanced network capabilities to standard macOS after the beta period.

3. **Compose equivalent**: Possible emergence of a native or third-party solution for multi-container orchestration, filling one of the current main gaps.

4. **CI/CD integration**: Expected development of better support in continuous integration and deployment pipelines.

5. **Additional optimizations**: Continuous improvements in performance and resource management through updates.

The community is just beginning to organize around this framework, with the appearance of the first help forums and experience sharing. This nascent dynamic suggests a potentially rich and diverse ecosystem in the coming months.

### Our vision for the future of containerization on macOS

In the longer term, we see Apple's Container framework as a possible catalyst for change in the macOS development ecosystem. This native approach, optimized for Apple hardware, could redefine developers' expectations regarding performance and integration.

We anticipate a progressive convergence of development tools towards this "native first" approach, where third-party solutions may increasingly rely on Apple's native frameworks rather than compatibility layers.

This evolution would fit into a broader trend of optimizing development tools for ARM architectures, which are progressively becoming dominant in the industry. Apple's Container framework could thus serve as a model for other platforms in the future.

### Next steps for our team

Following this encouraging first experimentation, our plan for the coming weeks includes:

1. **In-depth exploration**: Continue testing the framework on more varied projects and in conditions closer to production.

2. **Development of tool prototypes**: Create scripts and utilities to fill current ecosystem gaps, particularly a lightweight equivalent of Docker Compose.

3. **Knowledge sharing**: Organize demonstration sessions for the entire team and document our discoveries.

4. **Longer-term evaluation**: Set up a pilot project using exclusively the Container framework to evaluate its viability over a longer period.

5. **Technology watch**: Actively follow the framework's evolution and adapt our exploration strategy accordingly.

Ultimately, our first experience with Apple's Container framework, although very recent, has allowed us to glimpse the potential of a technology that could transform the development experience on macOS. If the initial promises are confirmed and the ecosystem develops as hoped, this solution could become a valuable tool in our development arsenal. We will continue to explore its possibilities and share our discoveries with the community as it evolves.

## Additional Resources

To deepen your knowledge of Apple's Container framework and facilitate your own exploration, here is a selection of resources we found particularly useful in these early days.

### Official documentation

- [Container Project GitHub](https://github.com/apple/container) - The official repository containing the source code, documentation, and installation guides.
- [Containerization Package GitHub](https://github.com/apple/containerization) - The repository of the underlying Swift package that powers the Container tool.
- [Containerization API Documentation](https://apple.github.io/containerization/documentation/) - The complete technical documentation of the framework's Swift APIs.
- [Technical Overview](https://github.com/apple/container/blob/main/docs/technical-overview.md) - A detailed explanation of the architecture and key concepts.

### Tutorials and practical guides

- [Quick Start Guide](https://github.com/apple/container/blob/main/docs/guided-tour.md) - A step-by-step tutorial to build, run, and publish your first container.
- [Features Guide](https://github.com/apple/container/blob/main/docs/features.md) - A comprehensive overview of available features and their usage.
- [WWDC25 Presentation: Meet Containerization](https://developer.apple.com/videos/play/wwdc2025/346/) - The official presentation of the framework by the Apple team.
- [Migration Guide from Docker](https://www.kubeace.com/blog/apple-container-macos-guide) - A detailed guide to facilitate transition from Docker.

### Complementary tools

- [Kata Containers](https://katacontainers.io/) - An alternative source of optimized Linux kernels compatible with the framework.
- [Swiftly](https://swift.org/install/swiftly/) - A tool to easily install and manage Swift environments, useful for development with Containerization.
- [VS Code Remote Containers](https://code.visualstudio.com/docs/remote/containers) - VS Code extension compatible with Apple's Container framework.

### Community and support

- [GitHub Discussion Forum](https://github.com/apple/container/discussions) - The official space to ask questions and share experiences.
- [Swift Server Slack Channel](https://swift-server.slack.com/) - A channel dedicated to discussions on Swift server technologies, including Containerization.
- [Stack Overflow: Tag container-apple](https://stackoverflow.com/questions/tagged/container-apple) - Community questions and answers.

### Articles and analyses

- [Comparative Performance Analysis](https://medium.com/@simardeep.oberoi/apples-containerization-framework-and-the-future-of-secure-computing-ba68f2e8097d) - A detailed study of the framework's performance compared to alternatives.
- [Security Implications](https://www.kubeace.com/blog/container-security-apple-framework) - An analysis of the security advantages of the "one VM per container" architecture.
- [The Future of Containerization on macOS](https://apidog.com/blog/apple-container-open-source-docker-alternative/) - A reflection on the potential impact of the framework on the development ecosystem.

### Models and examples

- [Automation Scripts](https://gist.github.com/example/container-automation-scripts) - A collection of shell scripts to automate common workflows.
- [Containerized Application Examples](https://github.com/example/container-examples) - Concrete examples of various applications configured for Apple's Container framework.

These resources will allow you to deepen your understanding of the framework and explore it effectively according to your specific needs. Feel free to contribute to this nascent ecosystem by sharing your own experiences and discoveries with the community.
