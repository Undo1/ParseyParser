//
//  main.swift
//  ParseyParser
//
//  Created by Undo on 6/23/16. Licensed under CC0
//

import Foundation

extension String {
    func matchesForRegex(regex: String!) -> [[String]] {

        let regex = try! NSRegularExpression(pattern: regex,
                                            options: NSRegularExpressionOptions.CaseInsensitive)


        let nsString = self as NSString
        let results = regex.matchesInString(self, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, nsString.length))

        var captureGroups: [[String]] = []

        for result in results
        {
            var captures: [String] = []
            if result.numberOfRanges > 1
            {
                for i in 1...(result.numberOfRanges - 1) {
                    captures.append(nsString.substringWithRange(result.rangeAtIndex(i)))
                }
            }
            captureGroups.append(captures)
        }

        return captureGroups
    }
}

func printWordDependencies(parents: [[String]]!, linesByParent: [String: [[String]]])
{
    if let dependentWords = linesByParent[(parents.last?.first)!]
    {
        for dependentWord in dependentWords // [String] in [[String]]
        {
            var output = ""
            for parent in parents {
                output += parent[1].lowercaseString + " (" + parent[3] + ") -> "
            }
            output += dependentWord[1].lowercaseString + " (" + dependentWord[3] + ")"

            if (linesByParent[dependentWord[0]] == nil)
            {
                print(output)
            }

            var ammendedParents = parents
            ammendedParents.append(dependentWord)

            printWordDependencies(ammendedParents, linesByParent: linesByParent)
        }
    }
}
func go(lines: [String])
{
    if lines.count == 0
    {
        return
    }

    let text = lines.joinWithSeparator("\n")
    let root = text.matchesForRegex("(\\d*)\\s*(\\w*)\\s*(\\w*)\\s*(\\w*)\\s*(\\w*)\\s*.\\s*\\d+\\s*(root)")

    var linesByParent: [String: [[String]]] = [:]

    for line in lines {
        let components = line.componentsSeparatedByString("\t")

        if linesByParent[components[6]] == nil
        {
            linesByParent[components[6]] = [components]
        }
        else
        {
            linesByParent[components[6]]?.append(components)
        }
    }

    printWordDependencies(root, linesByParent: linesByParent)
}

var lines: [String] = []

let newlineChars = NSCharacterSet.newlineCharacterSet()

while let line = readLine()
{
    if line.characters.count == 0 || (line.characters.count == 1 && newlineChars.characterIsMember(line.utf16.first!)) || line == "GO"
    {
        go(lines)
        lines = []

        if line == "GO" {
            break
        }
        else
        {
            continue
        }
    }

    lines.append(line)
}
