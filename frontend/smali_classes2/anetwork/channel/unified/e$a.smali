.class Lanetwork/channel/unified/e$a;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanetwork/channel/unified/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field a:I

.field b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lanet/channel/bytes/ByteArray;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(ILjava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    .line 607
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 605
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lanetwork/channel/unified/e$a;->c:Ljava/util/List;

    iput p1, p0, Lanetwork/channel/unified/e$a;->a:I

    iput-object p2, p0, Lanetwork/channel/unified/e$a;->b:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method a(Lanetwork/channel/interceptor/Callback;I)I
    .locals 3

    iget v0, p0, Lanetwork/channel/unified/e$a;->a:I

    iget-object v1, p0, Lanetwork/channel/unified/e$a;->b:Ljava/util/Map;

    .line 619
    invoke-interface {p1, v0, v1}, Lanetwork/channel/interceptor/Callback;->onResponseCode(ILjava/util/Map;)V

    iget-object v0, p0, Lanetwork/channel/unified/e$a;->c:Ljava/util/List;

    .line 621
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x1

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/bytes/ByteArray;

    .line 622
    invoke-interface {p1, v1, p2, v2}, Lanetwork/channel/interceptor/Callback;->onDataReceiveSize(IILanet/channel/bytes/ByteArray;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return v1
.end method

.method a()V
    .locals 2

    iget-object v0, p0, Lanetwork/channel/unified/e$a;->c:Ljava/util/List;

    .line 613
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/bytes/ByteArray;

    .line 614
    invoke-virtual {v1}, Lanet/channel/bytes/ByteArray;->recycle()V

    goto :goto_0

    :cond_0
    return-void
.end method
