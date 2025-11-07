{ config, pkgs, ... }:

{
  # Cybersecurity and Ethical Hacking Tools Configuration
  # Based on hack flake packages

  home.packages = with pkgs; [
    # Network analysis and scanning
    nmap
    wireshark
    tcpdump
    netcat-gnu

    # Web security testing
    dirb
    gobuster
    nikto

    # Binary analysis and reverse engineering
    radare2
    ghidra
    binwalk
    file
    hexdump

    # Cryptography and forensics
    john
    hashcat
    steghide

    # Python security tools ecosystem
    python3
    python3Packages.pip
    python3Packages.requests
    python3Packages.beautifulsoup4
    python3Packages.scapy

    # Penetration testing frameworks
    metasploit
    sqlmap

    # System utilities
    wget
    curl
    unzip
    zip

    # Additional useful tools
    hydra
    burpsuite
    aircrack-ng
  ];

  # XDG desktop entries for GUI security tools
  xdg.desktopEntries = {
    burpsuite = {
      name = "Burp Suite";
      comment = "Web application security testing";
      exec = "burpsuite";
      icon = "burpsuite";
      categories = [ "Network" "Security" ];
    };

    wireshark = {
      name = "Wireshark";
      comment = "Network protocol analyzer";
      exec = "wireshark";
      icon = "wireshark";
      categories = [ "Network" "Security" ];
    };

    ghidra = {
      name = "Ghidra";
      comment = "Software reverse engineering suite";
      exec = "ghidra";
      icon = "ghidra";
      categories = [ "Development" "Security" ];
    };
  };

  # Shell aliases for common security commands
  programs.zsh.shellAliases = {
    # Network scanning
    nmap-quick = "nmap -T4 -F";
    nmap-full = "nmap -T4 -A -v";

    # Web enumeration
    gobuster-dir = "gobuster dir -u";

    # Password attacks  
    john-wordlist = "john --wordlist=";
    hydra-ssh = "hydra -l user -P";

    # Network analysis
    tcpdump-http = "sudo tcpdump -i any -s 0 -A 'tcp port 80'";

    # Binary analysis
    strings-printable = "strings -a -t x";
    hexdump-canonical = "hexdump -C";
  };

  programs.bash.shellAliases = {
    # Network scanning
    nmap-quick = "nmap -T4 -F";
    nmap-full = "nmap -T4 -A -v";

    # Web enumeration
    gobuster-dir = "gobuster dir -u";

    # Password attacks
    john-wordlist = "john --wordlist=";
    hydra-ssh = "hydra -l user -P";

    # Network analysis
    tcpdump-http = "sudo tcpdump -i any -s 0 -A 'tcp port 80'";

    # Binary analysis
    strings-printable = "strings -a -t x";
    hexdump-canonical = "hexdump -C";
  };
}

