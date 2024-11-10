//
//  Tip.swift
//  bikeparking
//
//  Created by Simone Tesini on 02/11/24.
//

import SwiftData
import PhotosUI

@Model
final class Tip {
    var title: String
    var desc: String
    var imageData: Data?
    
    init(title: String, desc: String, imageData: Data? = nil) {
        self.title = title
        self.desc = desc
        self.imageData = imageData
    }

    func setAppleImage(_ image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.8)
    }
    
    func getAppleImage() -> UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension Tip {
    static var sampleData = [
        Tip(title: "Come chiudere bene la bici", desc: """
            1.Scegli un buon lucchetto: Utilizza un lucchetto di qualità, preferibilmente a U (detto anche "a ferro di cavallo"), poiché sono molto più difficili da rompere rispetto ai cavi sottili.
            2. Assicura il telaio e una ruota: Passa il lucchetto attraverso il telaio e almeno una ruota, preferibilmente quella posteriore, fissandolo a un punto stabile come un portabici o un palo resistente. In questo modo, la bici sarà più difficile da rimuovere.
            3. Evita i luoghi isolati: Parcheggia la bici in un'area ben illuminata e possibilmente frequentata, in modo che sia sempre visibile. I luoghi con videosorveglianza sono ideali.
            4. Usa un secondo lucchetto: Se possibile, usa un secondo lucchetto per bloccare l’altra ruota, oppure un antifurto aggiuntivo per dissuadere ulteriormente i ladri.
            5. Fai attenzione a come posizioni il lucchetto: Posiziona il lucchetto in modo che sia rivolto verso il basso e stretto intorno al telaio, in modo da ridurre lo spazio per eventuali attrezzi da scasso.
            Seguendo questi accorgimenti, potrai ridurre significativamente il rischio di furto e proteggere meglio la tua bici quando la lasci parcheggiata!
""", imageData: UIImage(named: "lockett")?.jpegData(compressionQuality: 1.0)),
        Tip(title: "Come scegliere un buon lucchetto", desc: """
        Per proteggere la tua bici dai furti, è importante scegliere un lucchetto robusto e di qualità. I lucchetti a U, ad esempio, sono tra i più sicuri: la loro struttura in acciaio resistente rende difficile l’uso di attrezzi da scasso, anche se sono meno pratici da trasportare. Le catene robuste sono una buona alternativa, poiché offrono flessibilità e alta sicurezza, ma possono essere pesanti.

        I lucchetti a cavo o spirale, invece, sono leggeri e facili da usare, ma offrono una sicurezza limitata, quindi sono più indicati per soste brevi. Infine, i lucchetti pieghevoli combinano praticità e robustezza e sono comodi da portare in giro. In generale, blocca sempre sia il telaio sia una ruota e fissa la bici a un punto stabile, preferibilmente in aree ben visibili e frequentate.
""", imageData: UIImage(named: "manylockets")?.jpegData(compressionQuality: 1.0))
    ]
}
