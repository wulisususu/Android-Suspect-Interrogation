.class Lcom/taobao/monitor/impl/data/g$c;
.super Ljava/lang/Object;
.source "LineTreeCalculator.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "c"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lcom/taobao/monitor/impl/data/g$b;",
        ">;"
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/impl/data/g$a;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/g$c;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/data/g$b;Lcom/taobao/monitor/impl/data/g$b;)I
    .locals 4

    .line 1
    iget v0, p1, Lcom/taobao/monitor/impl/data/g$b;->a:I

    iget v1, p2, Lcom/taobao/monitor/impl/data/g$b;->a:I

    const/4 v2, -0x1

    if-ge v0, v1, :cond_0

    return v2

    :cond_0
    const/4 v3, 0x1

    if-ne v0, v1, :cond_2

    .line 4
    iget p1, p1, Lcom/taobao/monitor/impl/data/g$b;->d:I

    iget p2, p2, Lcom/taobao/monitor/impl/data/g$b;->d:I

    if-ne p1, p2, :cond_1

    const/4 p1, 0x0

    return p1

    :cond_1
    if-nez p1, :cond_2

    return v2

    :cond_2
    return v3
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/data/g$b;

    check-cast p2, Lcom/taobao/monitor/impl/data/g$b;

    invoke-virtual {p0, p1, p2}, Lcom/taobao/monitor/impl/data/g$c;->a(Lcom/taobao/monitor/impl/data/g$b;Lcom/taobao/monitor/impl/data/g$b;)I

    move-result p1

    return p1
.end method
