.class final Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;
.super Lkotlin/jvm/internal/Lambda;
.source "BasicMarquee.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function3;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/compose/foundation/BasicMarqueeKt;->basicMarquee-1Mj1MLw(Landroidx/compose/ui/Modifier;IIIILandroidx/compose/foundation/MarqueeSpacing;F)Landroidx/compose/ui/Modifier;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function3<",
        "Landroidx/compose/ui/Modifier;",
        "Landroidx/compose/runtime/Composer;",
        "Ljava/lang/Integer;",
        "Landroidx/compose/ui/Modifier;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBasicMarquee.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BasicMarquee.kt\nandroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2\n+ 2 CompositionLocal.kt\nandroidx/compose/runtime/CompositionLocal\n+ 3 Composables.kt\nandroidx/compose/runtime/ComposablesKt\n+ 4 Composer.kt\nandroidx/compose/runtime/ComposerKt\n+ 5 Dp.kt\nandroidx/compose/ui/unit/Dp\n*L\n1#1,417:1\n76#2:418\n76#2:419\n83#3,3:420\n36#3:430\n1114#4,3:423\n1117#4,3:427\n1114#4,6:431\n88#5:426\n*S KotlinDebug\n*F\n+ 1 BasicMarquee.kt\nandroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2\n*L\n152#1:418\n153#1:419\n154#1:420,3\n173#1:430\n154#1:423,3\n154#1:427,3\n173#1:431,6\n166#1:426\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0001H\u000b\u00a2\u0006\u0004\u0008\u0002\u0010\u0003"
    }
    d2 = {
        "<anonymous>",
        "Landroidx/compose/ui/Modifier;",
        "invoke",
        "(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)Landroidx/compose/ui/Modifier;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $animationMode:I

.field final synthetic $delayMillis:I

.field final synthetic $initialDelayMillis:I

.field final synthetic $iterations:I

.field final synthetic $spacing:Landroidx/compose/foundation/MarqueeSpacing;

.field final synthetic $velocity:F


# direct methods
.method constructor <init>(IIIFLandroidx/compose/foundation/MarqueeSpacing;I)V
    .locals 0

    iput p1, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$iterations:I

    iput p2, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$delayMillis:I

    iput p3, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$initialDelayMillis:I

    iput p4, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$velocity:F

    iput-object p5, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$spacing:Landroidx/compose/foundation/MarqueeSpacing;

    iput p6, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$animationMode:I

    const/4 p1, 0x3

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)Landroidx/compose/ui/Modifier;
    .locals 9

    const-string v0, "$this$composed"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const p1, -0x21840cfd

    invoke-interface {p2, p1}, Landroidx/compose/runtime/Composer;->startReplaceableGroup(I)V

    const-string v0, "C151@7528L7,152@7583L7,153@7610L421,172@8136L39,172@8111L64:BasicMarquee.kt#71ulvw"

    invoke-static {p2, v0}, Landroidx/compose/runtime/ComposerKt;->sourceInformation(Landroidx/compose/runtime/Composer;Ljava/lang/String;)V

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->isTraceInProgress()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, -0x1

    const-string v1, "androidx.compose.foundation.basicMarquee.<anonymous> (BasicMarquee.kt:150)"

    .line 152
    invoke-static {p1, p3, v0, v1}, Landroidx/compose/runtime/ComposerKt;->traceEventStart(IIILjava/lang/String;)V

    :cond_0
    invoke-static {}, Landroidx/compose/ui/platform/CompositionLocalsKt;->getLocalDensity()Landroidx/compose/runtime/ProvidableCompositionLocal;

    move-result-object p1

    check-cast p1, Landroidx/compose/runtime/CompositionLocal;

    const p3, 0x789c5f52

    const-string v0, "CC:CompositionLocal.kt#9igjgp"

    .line 418
    invoke-static {p2, p3, v0}, Landroidx/compose/runtime/ComposerKt;->sourceInformationMarkerStart(Landroidx/compose/runtime/Composer;ILjava/lang/String;)V

    invoke-interface {p2, p1}, Landroidx/compose/runtime/Composer;->consume(Landroidx/compose/runtime/CompositionLocal;)Ljava/lang/Object;

    move-result-object p1

    invoke-static {p2}, Landroidx/compose/runtime/ComposerKt;->sourceInformationMarkerEnd(Landroidx/compose/runtime/Composer;)V

    .line 152
    check-cast p1, Landroidx/compose/ui/unit/Density;

    .line 153
    invoke-static {}, Landroidx/compose/ui/platform/CompositionLocalsKt;->getLocalLayoutDirection()Landroidx/compose/runtime/ProvidableCompositionLocal;

    move-result-object v1

    check-cast v1, Landroidx/compose/runtime/CompositionLocal;

    .line 419
    invoke-static {p2, p3, v0}, Landroidx/compose/runtime/ComposerKt;->sourceInformationMarkerStart(Landroidx/compose/runtime/Composer;ILjava/lang/String;)V

    invoke-interface {p2, v1}, Landroidx/compose/runtime/Composer;->consume(Landroidx/compose/runtime/CompositionLocal;)Ljava/lang/Object;

    move-result-object p3

    invoke-static {p2}, Landroidx/compose/runtime/ComposerKt;->sourceInformationMarkerEnd(Landroidx/compose/runtime/Composer;)V

    .line 153
    check-cast p3, Landroidx/compose/ui/unit/LayoutDirection;

    iget v0, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$iterations:I

    .line 155
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget v0, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$delayMillis:I

    .line 156
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iget v0, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$initialDelayMillis:I

    .line 157
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    iget v0, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$velocity:F

    .line 158
    invoke-static {v0}, Landroidx/compose/ui/unit/Dp;->box-impl(F)Landroidx/compose/ui/unit/Dp;

    move-result-object v4

    move-object v5, p1

    move-object v6, p3

    .line 160
    filled-new-array/range {v1 .. v6}, [Ljava/lang/Object;

    move-result-object v0

    iget v2, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$iterations:I

    iget v3, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$delayMillis:I

    iget v4, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$initialDelayMillis:I

    iget v1, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$velocity:F

    const v5, -0x21de6e89

    .line 154
    invoke-interface {p2, v5}, Landroidx/compose/runtime/Composer;->startReplaceableGroup(I)V

    const-string v8, "CC(remember)P(1):Composables.kt#9igjgp"

    invoke-static {p2, v8}, Landroidx/compose/runtime/ComposerKt;->sourceInformation(Landroidx/compose/runtime/Composer;Ljava/lang/String;)V

    const/4 v5, 0x0

    move v6, v5

    :goto_0
    const/4 v7, 0x6

    if-ge v5, v7, :cond_1

    .line 421
    aget-object v7, v0, v5

    invoke-interface {p2, v7}, Landroidx/compose/runtime/Composer;->changed(Ljava/lang/Object;)Z

    move-result v7

    or-int/2addr v6, v7

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 423
    :cond_1
    invoke-interface {p2}, Landroidx/compose/runtime/Composer;->rememberedValue()Ljava/lang/Object;

    move-result-object v0

    if-nez v6, :cond_2

    .line 424
    sget-object v5, Landroidx/compose/runtime/Composer;->Companion:Landroidx/compose/runtime/Composer$Companion;

    invoke-virtual {v5}, Landroidx/compose/runtime/Composer$Companion;->getEmpty()Ljava/lang/Object;

    move-result-object v5

    if-ne v0, v5, :cond_4

    .line 162
    :cond_2
    new-instance v0, Landroidx/compose/foundation/MarqueeModifier;

    .line 166
    sget-object v5, Landroidx/compose/ui/unit/LayoutDirection;->Ltr:Landroidx/compose/ui/unit/LayoutDirection;

    if-ne p3, v5, :cond_3

    const/high16 p3, 0x3f800000    # 1.0f

    goto :goto_1

    :cond_3
    const/high16 p3, -0x40800000    # -1.0f

    :goto_1
    mul-float/2addr v1, p3

    .line 426
    invoke-static {v1}, Landroidx/compose/ui/unit/Dp;->constructor-impl(F)F

    move-result v5

    const/4 v7, 0x0

    move-object v1, v0

    move-object v6, p1

    .line 162
    invoke-direct/range {v1 .. v7}, Landroidx/compose/foundation/MarqueeModifier;-><init>(IIIFLandroidx/compose/ui/unit/Density;Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 427
    invoke-interface {p2, v0}, Landroidx/compose/runtime/Composer;->updateRememberedValue(Ljava/lang/Object;)V

    .line 422
    :cond_4
    invoke-interface {p2}, Landroidx/compose/runtime/Composer;->endReplaceableGroup()V

    .line 154
    check-cast v0, Landroidx/compose/foundation/MarqueeModifier;

    iget-object p1, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$spacing:Landroidx/compose/foundation/MarqueeSpacing;

    .line 170
    invoke-virtual {v0, p1}, Landroidx/compose/foundation/MarqueeModifier;->setSpacing(Landroidx/compose/foundation/MarqueeSpacing;)V

    iget p1, p0, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->$animationMode:I

    .line 171
    invoke-virtual {v0, p1}, Landroidx/compose/foundation/MarqueeModifier;->setAnimationMode-97h66l8(I)V

    const p1, 0x44faf204

    .line 173
    invoke-interface {p2, p1}, Landroidx/compose/runtime/Composer;->startReplaceableGroup(I)V

    invoke-static {p2, v8}, Landroidx/compose/runtime/ComposerKt;->sourceInformation(Landroidx/compose/runtime/Composer;Ljava/lang/String;)V

    .line 430
    invoke-interface {p2, v0}, Landroidx/compose/runtime/Composer;->changed(Ljava/lang/Object;)Z

    move-result p1

    .line 431
    invoke-interface {p2}, Landroidx/compose/runtime/Composer;->rememberedValue()Ljava/lang/Object;

    move-result-object p3

    if-nez p1, :cond_5

    .line 432
    sget-object p1, Landroidx/compose/runtime/Composer;->Companion:Landroidx/compose/runtime/Composer$Companion;

    invoke-virtual {p1}, Landroidx/compose/runtime/Composer$Companion;->getEmpty()Ljava/lang/Object;

    move-result-object p1

    if-ne p3, p1, :cond_6

    .line 173
    :cond_5
    new-instance p1, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2$1$1;

    const/4 p3, 0x0

    invoke-direct {p1, v0, p3}, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2$1$1;-><init>(Landroidx/compose/foundation/MarqueeModifier;Lkotlin/coroutines/Continuation;)V

    move-object p3, p1

    check-cast p3, Lkotlin/jvm/functions/Function2;

    .line 434
    invoke-interface {p2, p3}, Landroidx/compose/runtime/Composer;->updateRememberedValue(Ljava/lang/Object;)V

    .line 430
    :cond_6
    invoke-interface {p2}, Landroidx/compose/runtime/Composer;->endReplaceableGroup()V

    check-cast p3, Lkotlin/jvm/functions/Function2;

    const/16 p1, 0x40

    .line 173
    invoke-static {v0, p3, p2, p1}, Landroidx/compose/runtime/EffectsKt;->LaunchedEffect(Ljava/lang/Object;Lkotlin/jvm/functions/Function2;Landroidx/compose/runtime/Composer;I)V

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->isTraceInProgress()Z

    move-result p1

    if-eqz p1, :cond_7

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->traceEventEnd()V

    :cond_7
    invoke-interface {p2}, Landroidx/compose/runtime/Composer;->endReplaceableGroup()V

    check-cast v0, Landroidx/compose/ui/Modifier;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 141
    check-cast p1, Landroidx/compose/ui/Modifier;

    check-cast p2, Landroidx/compose/runtime/Composer;

    check-cast p3, Ljava/lang/Number;

    invoke-virtual {p3}, Ljava/lang/Number;->intValue()I

    move-result p3

    invoke-virtual {p0, p1, p2, p3}, Landroidx/compose/foundation/BasicMarqueeKt$basicMarquee$2;->invoke(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)Landroidx/compose/ui/Modifier;

    move-result-object p1

    return-object p1
.end method
