abstract interface class AppConstants {
  static const privacyPolicyUrl = "https://google.com";
  static const termsAndConditions = "https://google.com";
  static final RegExp upiRegex = RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$');

}

class NewsDataList {
  final List<NewsModel> newsList = [
    NewsModel(
      title: "AI Revolution Continues Across Industries",
      description:
      "Companies worldwide are adopting artificial intelligence to improve productivity, automate complex workflows, and enhance customer experiences. Industry experts note that the transition from simple automation tools to complex autonomous agents marks a major turning point in corporate infrastructure.",
      imageUrl: "https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=800&q=80",
      author: "John Smith",
      publishedAt: "2026-06-17",
    ),
    NewsModel(
      title: "Space Agency Announces New Moon Mission",
      description:
      "The latest lunar mission aims to establish a sustainable human presence on the Moon within the next decade. International space organizations have finalized structural testing for the upcoming launch vehicle, which features a heavy payload transport architecture.",
      imageUrl: "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?auto=format&fit=crop&w=800&q=80",
      author: "Sarah Johnson",
      publishedAt: "2026-06-16",
    ),
    NewsModel(
      title: "Global Markets Show Strong Recovery",
      description:
      "Major stock indices posted significant gains as investors reacted positively to recent positive economic reports and balanced inflation parameters. Analytical models show an unexpected surge in tech and consumer goods sectors, providing stable market confidence.",
      imageUrl: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&w=800&q=80",
      author: "Michael Brown",
      publishedAt: "2026-06-15",
    ),
    NewsModel(
      title: "Electric Vehicles Reach Record Sales",
      description:
      "Electric vehicle adoption continues to accelerate globally as manufacturers introduce more affordable models and advanced battery platforms. Rapidly scaling urban networks and highway charging setups have effectively resolved range anxiety for everyday drivers.",
      imageUrl: "https://images.unsplash.com/photo-1563720223185-11003d516935?auto=format&fit=crop&w=800&q=80",
      author: "Emily Davis",
      publishedAt: "2026-06-14",
    ),
    NewsModel(
      title: "Scientists Discover New Deep-Sea Species",
      description:
      "Marine researchers have identified several previously unknown species during an extensive ocean exploration expedition. Operating near active hydrothermal vent fields, the deep-sea diving platforms captured pristine video logs of unusual organism adaptations.",
      imageUrl: "https://images.unsplash.com/photo-1682687220063-4742bd7fd538?auto=format&fit=crop&w=800&q=80",
      author: "David Wilson",
      publishedAt: "2026-06-13",
    ),
    NewsModel(
      title: "Renewable Energy Investments Hit New High",
      description:
      "Governments and private equity firms are rapidly increasing capital funding for large-scale solar arrays, wind capture projects, and next-generation clean grid developments. This massive investment surge aims to modernize legacy transmission structures across metropolitan hubs.",
      imageUrl: "https://images.unsplash.com/photo-1509391366360-2e959784a276?auto=format&fit=crop&w=800&q=80",
      author: "Sophia Taylor",
      publishedAt: "2026-06-12",
    ),
    NewsModel(
      title: "Major Breakthrough in Medical Research",
      description:
      "Researchers reported promising long-term results in the clinical development of highly customized mRNA treatments for complex chronic conditions. Patient data reveals enhanced metabolic response parameters and highly optimized cellular recovery pathways.",
      imageUrl: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=800&q=80",
      author: "Robert Lee",
      publishedAt: "2026-06-11",
    ),
    NewsModel(
      title: "Smart Cities Expand Across the Globe",
      description:
      "Urban centers are actively integrating distributed smart technologies to optimize traffic flow, minimize resource waste, and upgrade municipal logistics. Early metadata reports suggest immediate reductions in public utility expenditures and general carbon footprints.",
      imageUrl: "https://images.unsplash.com/photo-1519501025264-65ba15a82390?auto=format&fit=crop&w=800&q=80",
      author: "Jessica Martinez",
      publishedAt: "2026-06-10",
    ),
    NewsModel(
      title: "International Sports Event Draws Millions",
      description:
      "Fans around the world tuned in to watch one of the year's most highly anticipated sporting competitions via distributed live-streaming channels. Stadium operators noted record ticket conversions alongside historic secondary broadcast ad placement revenues.",
      imageUrl: "https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=800&q=80",
      author: "Daniel Clark",
      publishedAt: "2026-06-09",
    ),
    NewsModel(
      title: "New Smartphone Sets Performance Benchmark",
      description:
      "The latest flagship mobile handset introduces cutting-edge internal processing silicon, custom thermal cooling configurations, and dedicated on-device neural engines. Users can run multi-layered rendering software without relying on external cloud processing servers.",
      imageUrl: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=800&q=80",
      author: "Olivia Anderson",
      publishedAt: "2026-06-08",
    ),
    NewsModel(
      title: "Global AI Adoption Reaches New Milestone",
      description:
      "Artificial intelligence continues to transform legacy operations around the world. Businesses are integrating production models directly into real-time logistics networks, clinical tracking software, and modern automated systems to build more reliable predictive analytics.",
      imageUrl: "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?auto=format&fit=crop&w=800&q=80",
      author: "Emma Wilson",
      publishedAt: "2026-06-17",
    ),
    NewsModel(
      title: "Scientists Reveal Promising Clean Energy Technology",
      description:
      "Researchers have engineered a unique solid-state energy storage architecture that could significantly stabilize renewable grids during low-production weather windows. The discovery eliminates reliance on volatile raw materials while offering unmatched long-term cycle durability.",
      imageUrl: "https://images.unsplash.com/photo-1466611653911-95081537e5b7?auto=format&fit=crop&w=800&q=80",
      author: "Michael Roberts",
      publishedAt: "2026-06-16",
    ),
    NewsModel(
      title: "Space Exploration Program Announces Deep Space Mission",
      description:
      "A massive international space mission framework has been structured to analyze outer solar system anomalies. Engineering groups are developing specialized autonomous deep-space probes capable of functioning in high-radiation zones near planetary rings.",
      imageUrl: "https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80",
      author: "Sophia Turner",
      publishedAt: "2026-06-15",
    ),
    NewsModel(
      title: "Electric Vehicle Market Experiences Rapid Growth",
      description:
      "Global distribution metrics point to accelerating sales curves for multi-passenger electric utility vehicles. Car manufacturers are retooling active assembly infrastructure to accommodate structural cell-to-pack engineering designs for faster rollouts.",
      imageUrl: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=800&q=80",
      author: "James Carter",
      publishedAt: "2026-06-14",
    ),
    NewsModel(
      title: "Major Breakthrough Reported in Medical Research",
      description:
      "Clinical biologists have published encouraging data outlines focusing on target gene-regulatory mechanisms. The new methods could allow clinics to address underlying drivers of metabolic syndromes before adverse physiological symptoms manifest.",
      imageUrl: "https://images.unsplash.com/photo-1532187863486-abf9d39d6618?auto=format&fit=crop&w=800&q=80",
      author: "Olivia Bennett",
      publishedAt: "2026-06-13",
    ),
    NewsModel(
      title: "Global Economy Shows Signs of Stabilization",
      description:
      "Financial monitoring groups report notable resilience across international shipping lanes, employment indices, and industrial output fields. The favorable conditions have provided much-needed stabilization vectors for emerging market dependencies over the current season.",
      imageUrl: "https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?auto=format&fit=crop&w=800&q=80",
      author: "Daniel Walker",
      publishedAt: "2026-06-12",
    ),
    NewsModel(
      title: "Smart Cities Continue Expanding Worldwide",
      description:
      "Urban development authorities are investing heavily in cellular vehicle-to-everything (C-V2X) sensor layers. The implementation coordinates real-time crossing signals with automated public utility networks to systematically eradicate inner-city traffic congestions.",
      imageUrl: "https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?auto=format&fit=crop&w=800&q=80",
      author: "Ava Mitchell",
      publishedAt: "2026-06-11",
    ),
    NewsModel(
      title: "New Smartphone Series Introduces Advanced AI Features",
      description:
      "Mobile hardware firms are shipping multi-core processing architecture updates optimized for real-time translation pipelines and dynamic on-device generative photography adjustments, eliminating data-sharing security concerns during remote offline use.",
      imageUrl: "https://images.unsplash.com/photo-1598327105666-5b89351aff97?auto=format&fit=crop&w=800&q=80",
      author: "Liam Parker",
      publishedAt: "2026-06-10",
    ),
    NewsModel(
      title: "Researchers Discover Unique Deep Ocean Ecosystem",
      description:
      "A joint scientific venture operating advanced deep-diving remotely operated vehicles discovered a pristine biological habitat below the midnight ocean threshold. Initial samplings indicate the presence of fascinating, entirely unstudied chemosynthetic bacteria chains.",
      imageUrl: "https://images.unsplash.com/photo-1583212292454-1fe6229603b7?auto=format&fit=crop&w=800&q=80",
      author: "Charlotte Reed",
      publishedAt: "2026-06-09",
    ),
    NewsModel(
      title: "Global Tourism Industry Records Strong Recovery",
      description:
      "International transit records show a massive bounce back in regional traveler arrivals across coastal and cultural hubs. Tourism groups are focusing on eco-friendly, low-density travel frameworks to prevent overcrowding in historical conservation zones.",
      imageUrl: "https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?auto=format&fit=crop&w=800&q=80",
      author: "Benjamin Scott",
      publishedAt: "2026-06-08",
    ),
    NewsModel(
      title: "Education Sector Embraces Digital Learning Platforms",
      description:
      "Academic institutions are implementing custom virtual environments to facilitate immersive lab simulations and cross-border research pipelines. Teachers indicate that interactive content features keep distance learners highly engaged compared to traditional print curriculum models.",
      imageUrl: "https://images.unsplash.com/photo-1501504905252-473c47e087f8?auto=format&fit=crop&w=800&q=80",
      author: "Grace Hill",
      publishedAt: "2026-06-07",
    ),
    NewsModel(
      title: "Cybersecurity Experts Warn of Emerging Threats",
      description:
      "Digital protection agencies are prompting public and private institutions to overhaul baseline perimeter encryption schemas. Security architecture must be hardened immediately to counteract advanced automation tools utilized by decentralized bad actors.",
      imageUrl: "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=800&q=80",
      author: "Ethan Cooper",
      publishedAt: "2026-06-06",
    ),
    NewsModel(
      title: "International Sports Championship Draws Global Attention",
      description:
      "Sports broadcast corporations witnessed massive media consumption metrics during the weekend tournament cycle. Advanced streaming platforms with customized user interface layouts allowed viewers to select individual cameras and real-time biometric overlay graphics.",
      imageUrl: "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=800&q=80",
      author: "Victoria Adams",
      publishedAt: "2026-06-05",
    ),
    NewsModel(
      title: "Renewable Energy Capacity Continues to Expand",
      description:
      "National infrastructure planning boards have greenlit expansive wind-harvesting projects over offshore coastal areas. These industrial arrays will directly support municipal hydrogen generation complexes to cleanly supply regional cargo shipping routes.",
      imageUrl: "https://images.unsplash.com/photo-1413882353314-73389f63b6fd?auto=format&fit=crop&w=800&q=80",
      author: "Henry Foster",
      publishedAt: "2026-06-04",
    ),
    NewsModel(
      title: "Artificial Intelligence Improves Healthcare Diagnostics",
      description:
      "Hospital systems are actively deploying optimized image analysis software layers to evaluate complex diagnostic scans. Early feedback suggests automated scanning warnings significantly narrow processing windows for emergency clinical interventions.",
      imageUrl: "https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?auto=format&fit=crop&w=800&q=80",
      author: "Natalie Brooks",
      publishedAt: "2026-06-03",
    ),
    NewsModel(
      title: "Historic Restoration Project Nears Completion",
      description:
      "Cultural preservation agencies are finishing intricate restoration updates on iconic historical landmarks. Structural engineering teams combined classic building crafts with modern micro-reinforcement technology to preserve historical features.",
      imageUrl: "https://images.unsplash.com/photo-1590075865003-e48277afd558?auto=format&fit=crop&w=800&q=80",
      author: "Samuel Green",
      publishedAt: "2026-06-02",
    ),
    NewsModel(
      title: "Startup Ecosystem Sees Record Investment Activity",
      description:
      "Venture capital firms have reported a notable influx of late-stage series funding options tailored for environmental tech and robotics start-ups. Investors are moving away from speculative assets to focus strictly on real-world industrial utility assets.",
      imageUrl: "https://images.unsplash.com/photo-1515187029135-18ee286d815b?auto=format&fit=crop&w=800&q=80",
      author: "Isabella King",
      publishedAt: "2026-06-01",
    ),
    NewsModel(
      title: "Climate Research Highlights Environmental Challenges",
      description:
      "A multi-national environmental assessment report details critical shifting patterns in polar currents and oceanic baseline values. The researchers highlight a critical need for localized wetland restoration to serve as shock absorbers for shifting climates.",
      imageUrl: "https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?auto=format&fit=crop&w=800&q=80",
      author: "Andrew Phillips",
      publishedAt: "2026-05-31",
    ),
    NewsModel(
      title: "Next Generation Internet Technology Gains Momentum",
      description:
      "Telecommunications groups have kicked off advanced fiber-optic grid rollouts across primary regional manufacturing districts. The networking upgrades provide massive structural bandwidth limits required to run dense remote factory environments safely.",
      imageUrl: "https://images.unsplash.com/photo-1544197150-b99a580bb7a8?auto=format&fit=crop&w=800&q=80",
      author: "Mia Sullivan",
      publishedAt: "2026-05-30",
    ),
    NewsModel(
      title: "Robotics Industry Introduces Innovative Automation Solutions",
      description:
      "Engineering manufacturers have unveiled a fleet of responsive, dexterous automation units designed to coordinate safely side-by-side with human line operators, optimizing logistics packaging operations without restructuring warehouse facility floors.",
      imageUrl: "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?auto=format&fit=crop&w=800&q=80",
      author: "William Evans",
      publishedAt: "2026-05-29",
    ),
  ];
}

class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final String publishedAt;

  const NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
  });
}
