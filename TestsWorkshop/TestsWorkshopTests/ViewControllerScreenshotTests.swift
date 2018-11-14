import FBSnapshotTestCase
@testable import TestsWorkshop

class ViewControllerScreenshotTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
    }

    func testScreenshot() {
        let sizes: [CGSize] = [UIScreen.main.bounds.size,
                               CGSize(width: 100, height: 100),
                               CGSize(width: 1000, height: 70)]

        for size in sizes {
            let viewContoller = ViewController(apiService: MockedAPIService())
            viewContoller.view.frame = CGRect(origin: .zero, size: size)
            FBSnapshotVerifyView(viewContoller.view, identifier: "\(size.width)x\(size.height)")
        }
    }
}
