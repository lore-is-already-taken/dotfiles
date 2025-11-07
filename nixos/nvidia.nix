{ config, pkgs, ... }:

{
  # NVIDIA-specific Home Manager configuration
  
  # NVIDIA development and monitoring tools
  home.packages = with pkgs; [
    # NVIDIA system monitoring and management
    nvtopPackages.nvidia
    nvidia-system-monitor-qt
    
    # CUDA development tools (if needed)
    # cudatoolkit
    # cudnn
    
    # GPU benchmarking and testing
    glxinfo
    vulkan-tools
    mesa-demos
    
    # Video acceleration tools
    nvidia-vaapi-driver
    
    # Additional GPU utilities
    gpu-viewer
  ];

  # Environment variables for NVIDIA
  home.sessionVariables = {
    # Force NVIDIA GPU usage for certain applications
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
    
    # CUDA environment variables (uncomment if using CUDA)
    # CUDA_PATH = "${pkgs.cudatoolkit}";
    # CUDA_ROOT = "${pkgs.cudatoolkit}";
    # EXTRA_LDFLAGS = "-L${pkgs.cudatoolkit}/lib";
    # EXTRA_CCFLAGS = "-I${pkgs.cudatoolkit}/include";
  };

  # XDG desktop entries for NVIDIA applications
  xdg.desktopEntries = {
    nvidia-settings = {
      name = "NVIDIA Settings";
      comment = "Configure NVIDIA graphics driver";
      exec = "nvidia-settings";
      icon = "nvidia-settings";
      categories = [ "Settings" "HardwareSettings" ];
    };
    
    nvidia-system-monitor = {
      name = "NVIDIA System Monitor";
      comment = "Monitor NVIDIA GPU usage and statistics";
      exec = "qnvsm";
      icon = "nvidia-settings";
      categories = [ "System" "Monitor" ];
    };
  };

  # Shell aliases for NVIDIA commands
  programs.zsh.shellAliases = {
    nv-smi = "nvidia-smi";
    nv-settings = "nvidia-settings";
    nv-top = "nvtop";
    gpu-info = "nvidia-smi -q";
    gpu-temp = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
    gpu-usage = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
  };

  programs.bash.shellAliases = {
    nv-smi = "nvidia-smi";
    nv-settings = "nvidia-settings";
    nv-top = "nvtop";
    gpu-info = "nvidia-smi -q";
    gpu-temp = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
    gpu-usage = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
  };
}
