.class public Lcom/taobao/monitor/impl/data/g;
.super Ljava/lang/Object;
.source "LineTreeCalculator.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/g$d;,
        Lcom/taobao/monitor/impl/data/g$c;,
        Lcom/taobao/monitor/impl/data/g$b;
    }
.end annotation


# static fields
.field private static final a:Z = true

.field private static final b:Z = false


# instance fields
.field private final a:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(I)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/taobao/monitor/impl/data/g;->a:I

    return-void
.end method

.method private a(IILjava/util/List;)I
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/impl/data/g$b;",
            ">;)I"
        }
    .end annotation

    .line 32
    new-instance v0, Lcom/taobao/monitor/impl/data/g$d;

    const/4 v1, 0x0

    invoke-direct {v0, v1, p1, p2}, Lcom/taobao/monitor/impl/data/g$d;-><init>(III)V

    .line 36
    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    move p2, v1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lcom/taobao/monitor/impl/data/g$b;

    .line 37
    iget v2, p3, Lcom/taobao/monitor/impl/data/g$b;->a:I

    if-le v2, p2, :cond_1

    .line 38
    iget v3, v0, Lcom/taobao/monitor/impl/data/g$d;->a:I

    const/4 v4, 0x1

    if-le v3, v4, :cond_0

    sub-int p2, v2, p2

    add-int/lit8 v3, v3, -0x1

    mul-int/2addr p2, v3

    add-int/2addr v1, p2

    :cond_0
    move p2, v2

    .line 43
    :cond_1
    iget v2, p3, Lcom/taobao/monitor/impl/data/g$b;->d:I

    if-nez v2, :cond_2

    sget-boolean v2, Lcom/taobao/monitor/impl/data/g;->a:Z

    goto :goto_1

    :cond_2
    sget-boolean v2, Lcom/taobao/monitor/impl/data/g;->b:Z

    .line 44
    :goto_1
    invoke-direct {p0, v0, p3, v2}, Lcom/taobao/monitor/impl/data/g;->a(Lcom/taobao/monitor/impl/data/g$d;Lcom/taobao/monitor/impl/data/g$b;Z)V

    goto :goto_0

    :cond_3
    return v1
.end method

.method private a(Lcom/taobao/monitor/impl/data/g$d;)I
    .locals 2

    .line 119
    iget-object v0, p1, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    .line 120
    iget-object v1, p1, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    if-nez v0, :cond_0

    .line 121
    iget v0, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    goto :goto_0

    :cond_0
    iget v0, v0, Lcom/taobao/monitor/impl/data/g$d;->b:I

    :goto_0
    if-nez v1, :cond_1

    .line 122
    iget p1, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    goto :goto_1

    :cond_1
    iget p1, v1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    .line 124
    :goto_1
    invoke-static {v0, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    return p1
.end method

.method private a(IIIILjava/util/List;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(IIII",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/impl/data/k;",
            ">;)",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/impl/data/g$b;",
            ">;"
        }
    .end annotation

    .line 45
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 47
    invoke-interface {p5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p5

    :cond_0
    :goto_0
    invoke-interface {p5}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {p5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/monitor/impl/data/k;

    .line 48
    iget v2, v1, Lcom/taobao/monitor/impl/data/k;->a:I

    iget v3, p0, Lcom/taobao/monitor/impl/data/g;->a:I

    sub-int/2addr v2, v3

    invoke-static {p1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 49
    iget v3, v1, Lcom/taobao/monitor/impl/data/k;->b:I

    iget v4, p0, Lcom/taobao/monitor/impl/data/g;->a:I

    add-int/2addr v3, v4

    invoke-static {p2, v3}, Ljava/lang/Math;->min(II)I

    move-result v3

    if-gt v2, v3, :cond_0

    .line 52
    iget v4, v1, Lcom/taobao/monitor/impl/data/k;->c:I

    iget v5, p0, Lcom/taobao/monitor/impl/data/g;->a:I

    sub-int/2addr v4, v5

    if-lt v4, p3, :cond_1

    goto :goto_1

    :cond_1
    move v4, p3

    :goto_1
    invoke-static {v4, v2, v3}, Lcom/taobao/monitor/impl/data/g$b;->a(III)Lcom/taobao/monitor/impl/data/g$b;

    move-result-object v4

    const/4 v5, 0x0

    .line 53
    iput v5, v4, Lcom/taobao/monitor/impl/data/g$b;->d:I

    .line 54
    iget v1, v1, Lcom/taobao/monitor/impl/data/k;->d:I

    iget v5, p0, Lcom/taobao/monitor/impl/data/g;->a:I

    add-int/2addr v1, v5

    if-gt v1, p4, :cond_2

    goto :goto_2

    :cond_2
    move v1, p4

    .line 55
    :goto_2
    invoke-static {v1, v2, v3}, Lcom/taobao/monitor/impl/data/g$b;->a(III)Lcom/taobao/monitor/impl/data/g$b;

    move-result-object v1

    const/4 v2, 0x1

    .line 56
    iput v2, v1, Lcom/taobao/monitor/impl/data/g$b;->d:I

    .line 58
    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 59
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    return-object v0
.end method

.method private a(Lcom/taobao/monitor/impl/data/g$d;Lcom/taobao/monitor/impl/data/g$b;Z)V
    .locals 7

    .line 60
    iget v0, p1, Lcom/taobao/monitor/impl/data/g$d;->c:I

    .line 61
    iget v1, p1, Lcom/taobao/monitor/impl/data/g$d;->d:I

    .line 63
    iget v2, p2, Lcom/taobao/monitor/impl/data/g$b;->b:I

    const/4 v3, 0x0

    if-gt v2, v0, :cond_5

    iget v4, p2, Lcom/taobao/monitor/impl/data/g$b;->c:I

    if-lt v4, v1, :cond_5

    if-eqz p3, :cond_0

    .line 65
    iget v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    goto :goto_0

    .line 67
    :cond_0
    iget v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    add-int/lit8 v2, v2, -0x1

    iput v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    .line 70
    :goto_0
    iget-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    if-eqz v2, :cond_1

    .line 71
    invoke-direct {p0, v2, p2, p3}, Lcom/taobao/monitor/impl/data/g;->a(Lcom/taobao/monitor/impl/data/g$d;Lcom/taobao/monitor/impl/data/g$b;Z)V

    .line 73
    :cond_1
    iget-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    if-eqz v2, :cond_2

    .line 74
    invoke-direct {p0, v2, p2, p3}, Lcom/taobao/monitor/impl/data/g;->a(Lcom/taobao/monitor/impl/data/g$d;Lcom/taobao/monitor/impl/data/g$b;Z)V

    .line 77
    :cond_2
    iget p2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    if-lez p2, :cond_3

    sub-int/2addr v1, v0

    add-int/lit8 v1, v1, 0x1

    .line 78
    iput v1, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    goto :goto_1

    .line 80
    :cond_3
    iput v3, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    .line 81
    iget-object p2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    if-eqz p2, :cond_4

    .line 82
    iget p2, p2, Lcom/taobao/monitor/impl/data/g$d;->a:I

    iput p2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    .line 85
    :cond_4
    iget-object p2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    if-eqz p2, :cond_c

    .line 86
    iget p3, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    iget p2, p2, Lcom/taobao/monitor/impl/data/g$d;->a:I

    add-int/2addr p3, p2

    iput p3, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    goto :goto_1

    :cond_5
    add-int v4, v0, v1

    .line 91
    div-int/lit8 v4, v4, 0x2

    if-lt v4, v2, :cond_7

    .line 94
    iget-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    if-nez v2, :cond_6

    .line 95
    new-instance v2, Lcom/taobao/monitor/impl/data/g$d;

    iget v5, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    invoke-direct {v2, v5, v0, v4}, Lcom/taobao/monitor/impl/data/g$d;-><init>(III)V

    iput-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    .line 97
    :cond_6
    iget-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    invoke-direct {p0, v2, p2, p3}, Lcom/taobao/monitor/impl/data/g;->a(Lcom/taobao/monitor/impl/data/g$d;Lcom/taobao/monitor/impl/data/g$b;Z)V

    .line 100
    :cond_7
    iget v2, p2, Lcom/taobao/monitor/impl/data/g$b;->c:I

    if-ge v4, v2, :cond_9

    .line 101
    iget-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    if-nez v2, :cond_8

    .line 102
    new-instance v2, Lcom/taobao/monitor/impl/data/g$d;

    iget v5, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    add-int/lit8 v4, v4, 0x1

    iget v6, p1, Lcom/taobao/monitor/impl/data/g$d;->d:I

    invoke-direct {v2, v5, v4, v6}, Lcom/taobao/monitor/impl/data/g$d;-><init>(III)V

    iput-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    .line 104
    :cond_8
    iget-object v2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    invoke-direct {p0, v2, p2, p3}, Lcom/taobao/monitor/impl/data/g;->a(Lcom/taobao/monitor/impl/data/g$d;Lcom/taobao/monitor/impl/data/g$b;Z)V

    .line 107
    :cond_9
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/data/g;->a(Lcom/taobao/monitor/impl/data/g$d;)I

    move-result p2

    iput p2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:I

    if-lez p2, :cond_a

    sub-int/2addr v1, v0

    add-int/lit8 v1, v1, 0x1

    .line 110
    iput v1, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    goto :goto_1

    .line 112
    :cond_a
    iput v3, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    .line 113
    iget-object p2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:Lcom/taobao/monitor/impl/data/g$d;

    if-eqz p2, :cond_b

    .line 114
    iget p2, p2, Lcom/taobao/monitor/impl/data/g$d;->a:I

    iput p2, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    .line 117
    :cond_b
    iget-object p2, p1, Lcom/taobao/monitor/impl/data/g$d;->b:Lcom/taobao/monitor/impl/data/g$d;

    if-eqz p2, :cond_c

    .line 118
    iget p3, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    iget p2, p2, Lcom/taobao/monitor/impl/data/g$d;->a:I

    add-int/2addr p3, p2

    iput p3, p1, Lcom/taobao/monitor/impl/data/g$d;->a:I

    :cond_c
    :goto_1
    return-void
.end method


# virtual methods
.method public a(Landroid/view/View;Ljava/util/List;Landroid/view/View;)F
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/impl/data/k;",
            ">;",
            "Landroid/view/View;",
            ")F"
        }
    .end annotation

    const/4 v0, 0x0

    if-eqz p2, :cond_7

    .line 1
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_2

    .line 5
    :cond_0
    invoke-static {p1, p3}, Lcom/taobao/monitor/impl/data/l;->a(Landroid/view/View;Landroid/view/View;)[I

    move-result-object p3

    const/4 v1, 0x1

    .line 7
    aget v2, p3, v1

    const/4 v3, 0x0

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 8
    sget v4, Lcom/taobao/monitor/impl/data/l;->b:I

    aget v1, p3, v1

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v5

    add-int/2addr v1, v5

    invoke-static {v4, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 10
    aget v4, p3, v3

    invoke-static {v3, v4}, Ljava/lang/Math;->max(II)I

    move-result v7

    .line 11
    sget v4, Lcom/taobao/monitor/impl/data/l;->a:I

    aget p3, p3, v3

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result p1

    add-int/2addr p3, p1

    invoke-static {v4, p3}, Ljava/lang/Math;->min(II)I

    move-result v8

    sub-int p1, v8, v7

    if-lez p1, :cond_1

    goto :goto_0

    :cond_1
    move p1, v3

    :goto_0
    sub-int p3, v1, v2

    if-lez p3, :cond_2

    move v3, p3

    :cond_2
    mul-int/2addr p1, v3

    if-nez p1, :cond_3

    return v0

    :cond_3
    move-object v4, p0

    move v5, v2

    move v6, v1

    move-object v9, p2

    .line 21
    invoke-direct/range {v4 .. v9}, Lcom/taobao/monitor/impl/data/g;->a(IIIILjava/util/List;)Ljava/util/List;

    move-result-object p2

    .line 22
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p3

    if-nez p3, :cond_4

    return v0

    .line 26
    :cond_4
    new-instance p3, Lcom/taobao/monitor/impl/data/g$c;

    const/4 v0, 0x0

    invoke-direct {p3, v0}, Lcom/taobao/monitor/impl/data/g$c;-><init>(Lcom/taobao/monitor/impl/data/g$a;)V

    invoke-static {p2, p3}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 27
    invoke-direct {p0, v2, v1, p2}, Lcom/taobao/monitor/impl/data/g;->a(IILjava/util/List;)I

    move-result p3

    int-to-float p3, p3

    const/high16 v0, 0x3f800000    # 1.0f

    mul-float/2addr p3, v0

    int-to-float p1, p1

    div-float/2addr p3, p1

    .line 29
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_5
    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_6

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/taobao/monitor/impl/data/g$b;

    if-eqz p2, :cond_5

    .line 31
    invoke-static {p2}, Lcom/taobao/monitor/impl/data/g$b;->a(Lcom/taobao/monitor/impl/data/g$b;)V

    goto :goto_1

    :cond_6
    return p3

    :cond_7
    :goto_2
    return v0
.end method
