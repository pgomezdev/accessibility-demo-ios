//
//  BudgetGraph.swift
//  AccessibilityDemo
//

import SwiftUI

struct BudgetGraph: View {
    @Environment(\.dynamicTypeSize) var typeSize
    
    let budgets: [Budget]
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Canvas { ctx, size in
                    if typeSize.isAccessibilitySize {
                        drawRows(ctx: ctx, size: size, budgets: budgets, inset: 0)
                    } else {
                        drawColumns(ctx: ctx, size: size, budgets: budgets, inset: 25)
                    }
                }
                .accessibilityLabel("budget.graph.title")
                .accessibilityChildren {
                    if typeSize.isAccessibilitySize {
                        VStack {
                            ForEach(budgets) { budget in
                                Rectangle()
                                    .accessibilityLabel(String.monthName(from: budget.month) ?? budget.id)
                                    .accessibilityValue(String.localizedCurrency(from: budget.amount, maxDecimals: 0))
                            }
                        }
                    } else {
                        HStack {
                            ForEach(budgets) { budget in
                                Rectangle()
                                    .accessibilityLabel(String.monthName(from: budget.month) ?? budget.id)
                                    .accessibilityValue(String.localizedCurrency(from: budget.amount, maxDecimals: 0))
                            }
                        }
                    }
                }
                
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(UIColor.systemBackground))
            )
        .padding(.horizontal)
    }
    
    private func drawColumns(ctx: GraphicsContext, size: CGSize, budgets: [Budget], inset: CGFloat) {
        let insetSize = CGSize(width: size.width, height: size.height - inset * 2)
        let width = insetSize.width / CGFloat(budgets.count)
        let max = budgets.map(\.amount).max() ?? 0
        for n in budgets.indices {
            let x = width * CGFloat(n)
            let height = (CGFloat(budgets[n].amount) / CGFloat(max)) * insetSize.height
            let y = insetSize.height - height
            let p = Path(
                roundedRect: CGRect(
                    x: x + 2.5,
                    y: y + inset,
                    width: width - 5,
                    height: height),
                cornerRadius: 4)
            ctx.fill(p, with: .color(Color.green))
            
            ctx.draw(Text(String.localizedCurrency(from: budgets[n].amount, maxDecimals: 0)), at: CGPoint(x: x + width / 2, y: y + inset / 2))
            
            if let month = String.monthName(from: budgets[n].month) {
                ctx.draw(Text(month), at: CGPoint(x: x + width / 2, y: y + height + 1.5*inset))
            }
        }
    }
    
    private func drawRows(ctx: GraphicsContext, size: CGSize, budgets: [Budget], inset: CGFloat) {
        let insetSize = CGSize(width: size.width - inset * 2, height: size.height)
        let height = insetSize.height / CGFloat(budgets.count)
        let max = budgets.map(\.amount).max() ?? 0
        for n in budgets.indices {
            let y = height * CGFloat(n)
            let width = (CGFloat(budgets[n].amount) / CGFloat(max)) * insetSize.width
            let p = Path(
                roundedRect: CGRect(
                    x: inset,
                    y: y + 2.5,
                    width: width,
                    height: height - 5),
                cornerRadius: 4)
            ctx.fill(p, with: .color(Color.green))
            
            ctx.draw(Text(String.localizedCurrency(from: budgets[n].amount, maxDecimals: 0)), at: CGPoint(x: 100, y: y + height / 2))
            
            if let month = String.monthName(from: budgets[n].month) {
                ctx.draw(Text(month), at: CGPoint(x: insetSize.width - 50, y: y + height / 2))
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BudgetGraph(budgets: StubData.budgets)
}
