import UIKit

enum PasswordError: Error {
    case empty
    case short
    case obvious(message: String)
}

func encrypt(_ str: String, with password: String) throws -> String {
    let encrypted = password + str + password
    return String(encrypted.reversed())
}

func testCatch() {
    do {
        let encrypted = try encrypt("Secret", with: "T4yl0r")
        print(encrypted)
    } catch PasswordError.empty {
        print ("No password")
    } catch PasswordError.short {
        print("Your password is too short")
    } catch PasswordError.obvious(let message) {
        print("Your password: \(message) is too obvious")
    }
    catch {
        print("Encryption failed!")
    }
}

testCatch()
