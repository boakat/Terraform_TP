# Terraform mes travaux dirigés

    

  # TP3 : Déployez une infrastructure dynamique

  - L'objectif est de déployez une instance ec2 avec ip publique et un security group
  - IP publique : vous allez créer une IP publique pour votre ec2
  - Security Group : créez une security group pour ouvrir port 80
  et 443 ,attachez cette security group à votre IP publique
  - Votre EC2 doit avoir une taille variabilisée , la valeur par défaut devrait être t2.nano et la valeur à surchargé sera t2.micro
  - l'image AMI à utiliser sera l'image la plus à jour de AMAZON linux
  - Spécifiez la key pair à utiliser (devops<votre_prenom>)
  - Attachez l'IP publique à votre instance
  - Variabilisez le tag afin qu'il contienne au moins le tag : << Name : ec2 - <prenom> >> le N est bien en majuscule



  # TP4 : Déployez nginx et enregistrez l'ip

  - A partir du code du tp-3 , vous allez le modifier pour installer nginx sur votre VM
  - Vous allez récupérer l'IP ,ID de la zone de disponibilité de la VM et vous mettrez dans un fichier nommé infos_ec2.txt


  # TP5 : Remote backend

  - Créez un S3 nommé terraform-backend <votre_prenom>
  - Modifiez votre rendre du tp-4 afin d'y integrer le stockage de tfstate sur S3
  - Vérifiez après avoir lancer un déploiement que le fichier sur le drive est crée et contient bien les infos à jour

