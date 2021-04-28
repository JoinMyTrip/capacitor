import Foundation

extension InstanceConfiguration {
    @objc var appStartFileURL: URL {
        let url = appLocation
        let languageFound = false
        for language in Locale.preferredLanguages {
          let code = String(language.prefix(2))
          if (code == "de" || code == "en") {
            url = url.appendingPathComponent(code)
            languageFound = false
            break
          }
        }
        if (!languageFound) {
          url = url.appendingPathComponent("en")
        }
        if let path = appStartPath {
            return url.appendingPathComponent(path)
        }
        return url
    }

    @objc var appStartServerURL: URL {
        let url = serverURL
        let languageFound = false
        for language in Locale.preferredLanguages {
          let code = String(language.prefix(2))
          if (code == "de" || code == "en") {
            url = url.appendingPathComponent(code)
            languageFound = false
            break
          }
        }
        if (!languageFound) {
          url = url.appendingPathComponent("en")
        }
        if let path = appStartPath {
            return url.appendingPathComponent(path)
        }
        return url
    }

    @objc public func getPluginConfigValue(_ pluginId: String, _ configKey: String) -> Any? {
        return (pluginConfigurations as? JSObject)?[keyPath: KeyPath("\(pluginId).\(configKey)")]
    }

    @objc public func shouldAllowNavigation(to host: String) -> Bool {
        for hostname in allowedNavigationHostnames {
            if doesHost(host, match: hostname) {
                return true
            }
        }
        return false
    }

    @available(*, deprecated, message: "Use direct property accessors")
    @objc public func getValue(_ key: String) -> Any? {
        return (legacyConfig as? JSObject)?[keyPath: KeyPath(key)]
    }

    @available(*, deprecated, message: "Use direct property accessors")
    @objc public func getString(_ key: String) -> String? {
        return (legacyConfig as? JSObject)?[keyPath: KeyPath(key)] as? String
    }

    // MARK: - Private

    private func doesHost(_ host: String, match pattern: String) -> Bool {
        // bail early in the simple case
        if pattern == "*" {
            return true
        }
        // break apart the pieces
        var hostComponents = host.lowercased().split(separator: ".")
        var patternComponents = pattern.lowercased().split(separator: ".")
        guard hostComponents.count == patternComponents.count else {
            return false
        }
        // remove any wildcard segments
        for wildcard in patternComponents.enumerated().filter({ $0.element == "*" }) {
            hostComponents.remove(at: wildcard.offset)
            patternComponents.remove(at: wildcard.offset)
        }
        // match with what's left
        return hostComponents == patternComponents
    }
}
