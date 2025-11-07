{
  description = "Cybersecurity and ethical hacking development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "hack-dev-shell";
          
          buildInputs = with pkgs; [
            # Core development tools
            neovim
            git
            gcc
            
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
            strings
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
          
          shellHook = ''
            echo "🔐 Hack Development Environment"
            echo "==============================="
            echo "Available tools:"
            echo "  Network: nmap, wireshark, tcpdump, netcat"
            echo "  Web: dirb, gobuster, nikto, burpsuite"
            echo "  Binary: radare2, ghidra, binwalk"
            echo "  Crypto: john, hashcat, steghide"
            echo "  Frameworks: metasploit, sqlmap"
            echo ""
            echo "⚠️  Remember: Use these tools ethically and legally!"
            echo "   Only test on systems you own or have permission to test."
            echo ""
            export HACK_ENV=1
          '';
        };
      });
}
