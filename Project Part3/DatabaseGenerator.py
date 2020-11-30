import csv
import random


def getAntiVirus():
    return random.choice([1.0, 1.0, 0.3, 0.0])


def getBrowser():
    return random.choice([0.0, 0.8, 0.6, 0.8, 1.0, 0.3])


def getFirewall():
    return random.choice([1.0, 0.2, 0.0])


def getNou():
    return random.choice([1.0, 0.8, 0.6, 0.4, 0.3, 0.2, 0.05, 0.0])


def getPassword():
    return random.choice([1.0, 0.2, 0.0])


def getSecurityPatch():
    return random.choice([1.0, 0.1, 0.0])


def getSystem():
    return random.choice([0.9, 1.0, 0.9])


def getP2P():
    return random.choice([0.4, 1.0, 0.0])


def getArchitecture():
    return random.choice([0.0, 1.0, 0.8])


def get3rdPartyApps():
    return random.choice([0.0, 1.0, 0.6, 0.4, 0.2, 0.05])


def main():
    iterations = 839807
    iterations1 = 60000
    iterations2 = 300
    with open('dataset1.csv', 'w', newline='') as f:
        write = csv.writer(f)
        for _ in range(iterations1):
            SystemRating = getSystem()
            ArchitectureRating = getArchitecture()
            PasswordRating = getPassword()
            AntivirusRating = getAntiVirus()
            BrowsersRating = getBrowser()
            ThirdPartyAppsRating = get3rdPartyApps()
            NoOfUsersRating = getNou()
            FirewallRating = getFirewall()
            SecurityRating = getSecurityPatch()
            P2PRating = getP2P()
            TotalSecurityRating = (3.33 * ((0.3 * SystemRating) + (0.2 * ArchitectureRating) + (0.5 * PasswordRating)) +
                                   3.34 * ((0.3 * AntivirusRating) + (0.2 * BrowsersRating) + (0.4 * ThirdPartyAppsRating) +
                                           (0.1 * NoOfUsersRating)) +
                                   3.33 * ((0.4 * FirewallRating) + (0.3 * SecurityRating) + (0.3 * P2PRating)))/10
            write.writerow([SystemRating, ArchitectureRating, PasswordRating, AntivirusRating, BrowsersRating,
                            ThirdPartyAppsRating, NoOfUsersRating, FirewallRating, SecurityRating, P2PRating,
                            TotalSecurityRating])


if __name__ == '__main__':
    main()
