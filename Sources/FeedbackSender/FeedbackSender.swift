import MessageUI

public protocol FeedbackSender {
    func sendFeedback(subject: String, messageBody: String, recipients: [String])
}

public final class FeedbackSenderImp: NSObject, MFMailComposeViewControllerDelegate {
    public override init() {
        super.init()
    }

    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        rootVC?.dismiss(animated: true)
    }
}

extension FeedbackSenderImp: FeedbackSender {
    public func sendFeedback(subject: String, messageBody: String, recipients: [String]) {
        if MFMailComposeViewController.canSendMail() {
            let picker = MFMailComposeViewController()
            picker.setSubject(subject)
            picker.setMessageBody(messageBody, isHTML: false)
            picker.setToRecipients(recipients)
            picker.mailComposeDelegate = self
            rootVC?.present(picker, animated: true)
        } else {
            let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "Feedback"
            if let firstRecipient = recipients.first,
               let url = URL(string: "mailto:\(firstRecipient)?subject=\(encodedSubject)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

private extension FeedbackSenderImp {
    var rootVC: UIViewController? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
    }
}
