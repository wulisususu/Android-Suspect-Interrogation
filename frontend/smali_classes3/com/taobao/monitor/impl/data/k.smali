.class Lcom/taobao/monitor/impl/data/k;
.super Ljava/lang/Object;
.source "ViewInfo.java"


# static fields
.field private static a:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Lcom/taobao/monitor/impl/data/k;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public a:I

.field public a:Z

.field public b:I

.field public c:I

.field public d:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/data/k;->a:Ljava/util/Queue;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/view/View;Landroid/view/View;)Lcom/taobao/monitor/impl/data/k;
    .locals 7

    sget-object v0, Lcom/taobao/monitor/impl/data/k;->a:Ljava/util/Queue;

    .line 3
    invoke-interface {v0}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/k;

    if-nez v0, :cond_0

    .line 5
    new-instance v0, Lcom/taobao/monitor/impl/data/k;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/k;-><init>()V

    .line 8
    :cond_0
    invoke-static {p0, p1}, Lcom/taobao/monitor/impl/data/l;->a(Landroid/view/View;Landroid/view/View;)[I

    move-result-object p1

    .line 9
    instance-of v1, p0, Landroid/widget/TextView;

    const/4 v2, 0x0

    .line 10
    aget v3, p1, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 11
    sget v4, Lcom/taobao/monitor/impl/data/l;->a:I

    aget v5, p1, v2

    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v6

    add-int/2addr v5, v6

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    const/4 v5, 0x1

    .line 12
    aget v6, p1, v5

    invoke-static {v2, v6}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 13
    sget v6, Lcom/taobao/monitor/impl/data/l;->b:I

    aget p1, p1, v5

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result p0

    add-int/2addr p1, p0

    invoke-static {v6, p1}, Ljava/lang/Math;->min(II)I

    move-result p0

    .line 15
    iput-boolean v1, v0, Lcom/taobao/monitor/impl/data/k;->a:Z

    .line 16
    iput v3, v0, Lcom/taobao/monitor/impl/data/k;->c:I

    .line 17
    iput v4, v0, Lcom/taobao/monitor/impl/data/k;->d:I

    .line 18
    iput v2, v0, Lcom/taobao/monitor/impl/data/k;->a:I

    .line 19
    iput p0, v0, Lcom/taobao/monitor/impl/data/k;->b:I

    return-object v0
.end method


# virtual methods
.method public a()V
    .locals 2

    sget-object v0, Lcom/taobao/monitor/impl/data/k;->a:Ljava/util/Queue;

    .line 1
    invoke-interface {v0}, Ljava/util/Queue;->size()I

    move-result v0

    const/16 v1, 0x64

    if-ge v0, v1, :cond_0

    sget-object v0, Lcom/taobao/monitor/impl/data/k;->a:Ljava/util/Queue;

    .line 2
    invoke-interface {v0, p0}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "ViewInfo{top="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Lcom/taobao/monitor/impl/data/k;->a:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", bottom="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/taobao/monitor/impl/data/k;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", left="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/taobao/monitor/impl/data/k;->c:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", right="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/taobao/monitor/impl/data/k;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
