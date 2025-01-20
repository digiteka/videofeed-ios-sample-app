# Librairie VideoFeed de Digiteka

[![en](https://img.shields.io/badge/lang-en-red.svg)](ReadMe.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](ReadMe.fr.md)

La librairie VideoFeed de Digiteka fourni un composant interactif pour afficher des listes de contenus médias, organisés par catégories.

# Installation

Ajouter la dépendance à votre projet avec l'une de ces solutions :

## Swift Package Manager

Vous pouvez intégrer `VideoFeedSDK` en tant que package Swift en ajoutant l'URL suivante du repository public dans Xcode :

`https://github.com/digiteka/videofeed-ios-build.git`

# Utilisation

## UIKit

### UICollectionView

`VideoFeedCarousselCollectionViewCell` est une `UICollectionViewCell` personnalisée conçue pour afficher des éléments de flux vidéo dans une disposition de style carrousel.

Dans votre `UIViewController` ou `UICollectionViewController`, enregistrez la cellule avec votre `UICollectionView en utilisant l'extrait de code suivant :

```swift
collectionView.register(
    VideoFeedCarousselCollectionViewCell.nib, // Load the nib file
    forCellWithReuseIdentifier: "VideoFeedCarousselCollectionViewCell" // Assign a unique identifier
)
```

Pour charger le carroussel, vous pouvez utiliser l'extrait de code suivant :

```swift
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // [...]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoFeedCarousselCollectionViewCell", for: indexPath) as! VideoFeedCarousselCollectionViewCell
        cell.load(with: mdtk, delegate: self)
        return cell
        // [...]
    }
```



### UITableView

`VideoFeedCarrouselTableViewCell` est une `UITableViewCell` personnalisée conçue pour afficher des éléments de flux vidéo dans une présentation de type liste.

Dans votre `UIViewController` ou `UITableViewController`, enregistrez la cellule avec votre `UITableView` à l'aide de l'extrait de code suivant :

```swift
tableView.register(
    VideoFeedCarrouselTableViewCell.nib, // Load the nib file
    forCellReuseIdentifier: "VideoFeedTableViewCell" // Assign a unique identifier
)
```

Pour charger le carroussel, vous pouvez utiliser l'extrait de code suivant :

```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // [...]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoFeedCarousselTableViewCell", for: indexPath) as! VideoFeedCarrouselTableViewCell
        cell.load(with: mdtk, delegate: self)
        return cell
        // [...]
    }
```

### UIView

`VideoFeedCarrouselView` est une `UIView` personnalisée conçue pour afficher des éléments de flux vidéo dans une disposition de type carrousel :

```swift
self.carrouselView = VideoFeedCarrouselView(frame: .zero)
if let carrouselView_ = carrouselView {
    carrouselContainerview.addSubview(carrouselView_)
    carrouselView_.translatesAutoresizingMaskIntoConstraints = false

    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .leading, relatedBy: .equal, toItem: carrouselContainerview, attribute: .leading, multiplier: 1.0, constant: 0))
    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .trailing, relatedBy: .equal, toItem: carrouselContainerview, attribute: .trailing, multiplier: 1.0, constant: 0))
    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .top, relatedBy: .equal, toItem: carrouselContainerview, attribute: .top, multiplier: 1.0, constant: 0))
    carrouselContainerview.addConstraint(NSLayoutConstraint(item: carrouselView_, attribute: .bottom, relatedBy: .equal, toItem: carrouselContainerview, attribute: .bottom, multiplier: 1.0, constant: 0))
}
```

Pour charger le carroussel, vous pouvez utiliser l'extrait de code suivant :

```swift
self.carrouselView.load(with: mdtk, adunitPath: "networkCode/cheminDuBlocdAnnonce", delegate: self)
```

### Delegate

Chacune des vues ci-dessus peut prendre un delegate pour gérer les interactions des utilisateurs et ouvrir le  `VideoFeedViewController` selon vos besoins.

La classe delegate doit être conforme au protocole `VideoFeedCarousselDelegate` :

```swift
extension VideoFeedSampleCollectionViewController: VideoFeedCarousselDelegate {
    func didTapOnItem(at videoId: String) {
        self.navigationController?.pushViewController(VideoFeedViewController(videoId: videoId, mdtk: mdtk), animated: true)
    }
}
```

Si le paramètre delegate n'est pas défini, il présentera le `VideoFeedViewController` par lui-même.

## VideoFeedViewController

Le `VideoFeedSDK` fournit un `UIViewController` que vous pouvez utiliser comme vous le souhaitez

Il peut être utilisé avec un `videoId` et un `mdtk`.
Si aucun `videoId` n'est fourni, il affichera la première vidéo du flux.

```swift
let videoFeedViewController = VideoFeedViewController(videoId: videoId, mdtk: mdtk)
let videoFeedViewController = VideoFeedViewController(mdtk: mdtk)
```
## SwiftUI

### VideoFeedCarrouselViewSUI

`VideoFeedCarrouselViewSUI` est une vue SwiftUI personnalisée conçue pour afficher des éléments de flux vidéo dans une disposition de style carrousel :

```swift
var body: some View {
    
    VideoFeedCarrouselViewSUI(mdtk: mdtk)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)

    VideoFeedCarrouselViewSUI(mdtk: mdtk) { videoId in
        print("Selected videoId: \(videoId)")
    }
    .frame(maxWidth: .infinity)
    .frame(height: 300)
}
 
```

### VideoFeedViewSUI

`VideoFeedViewSUI` est une vue SwiftUI personnalisée conçue pour afficher des éléments de flux vidéo :

Elle peut être utilisée avec un `videoId` et un `mdtk`.
Si aucun `videoId` n'est fourni, elle affichera la première vidéo du flux.

```swift
    VideoFeedViewSUI(videoId: videoId, mdtk: mdtk)
    VideoFeedViewSUI(mdtk: mdtk)
```




# Compatibilité


Cette bibliothèque nécessite une cible de déploiement de `iOS 12.0` ou supérieure.

Les composants SwiftUI sont disponibles à partir de `iOS 13.0` ou supérieure.

# Exemple d'application
Vous pouvez tester l'exemple d'application à l'aide du mdtk : « 01472001 ».
