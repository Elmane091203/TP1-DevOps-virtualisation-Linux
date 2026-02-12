#!/bin/bash

TOMCAT_HOME="/opt/tomcat"
APP_PATH="/opt/project"
WAR_FILE="webapp.war"

while true; do
    echo ""
    echo "======================================"
    echo "  MENU DEPLOYMENT TOMCAT"
    echo "======================================"
    echo "1 Compiler l'application"
    echo "2 Déployer l'application"
    echo "3 Arrêter Tomcat"
    echo "4 Démarrer Tomcat"
    echo "5 Redémarrer Tomcat"
    echo "6 Voir le statut de Tomcat"
    echo "7 Afficher les logs"
    echo "8 Quitter"
    echo "======================================"
    
    read -p "Choisissez une option (1-8) : " choice
    
    case $choice in
        1)
            echo "🔨 Compilation en cours..."
            cd $APP_PATH
            mvn clean package
            if [ $? -eq 0 ]; then
                echo "✅ Compilation réussie !"
            else
                echo "❌ Erreur de compilation"
            fi
            ;;
        2)
            echo "📦 Déploiement en cours..."
            if [ -f "$APP_PATH/target/$WAR_FILE" ]; then
                sudo cp $APP_PATH/target/$WAR_FILE $TOMCAT_HOME/webapps/
                echo "✅ Application déployée !"
                echo "Accédez à : http://localhost:811/webapp"
            else
                echo "❌ Fichier WAR non trouvé. Compilez d'abord (option 1)"
            fi
            ;;
        3)
            echo "🛑 Arrêt de Tomcat..."
            sudo $TOMCAT_HOME/bin/shutdown.sh
            sleep 2
            echo "✅ Tomcat arrêté !"
            ;;
        4)
            echo "▶️  Démarrage de Tomcat..."
            sudo $TOMCAT_HOME/bin/startup.sh
            sleep 2
            echo "✅ Tomcat démarré !"
            ;;
        5)
            echo "🔄 Redémarrage de Tomcat..."
            sudo $TOMCAT_HOME/bin/shutdown.sh
            sleep 3
            sudo $TOMCAT_HOME/bin/startup.sh
            sleep 2
            echo "✅ Tomcat redémarré !"
            ;;
        6)
            echo "📊 Statut de Tomcat..."
            if pgrep -f "catalina" > /dev/null; then
                echo "✅ Tomcat est EN COURS D'EXÉCUTION"
                ps aux | grep catalina | grep -v grep
            else
                echo "⛔ Tomcat est ARRÊTÉ"
            fi
            ;;
        7)
            echo "📋 Affichage des logs (Ctrl+C pour quitter)..."
            tail -f $TOMCAT_HOME/logs/catalina.out
            ;;
        8)
            echo "👋 Au revoir !"
            exit 0
            ;;
        *)
            echo "❌ Option invalide"
            ;;
    esac
done
