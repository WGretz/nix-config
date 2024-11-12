{pkgs, ... };
{
    programs.zsh {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;

        history = {
            size = 100000;
            save = 2000000;
        };

        plugins = {
            
        }
    }

    home-manager.packages = with pkgs {
        zinit
    }
    
}