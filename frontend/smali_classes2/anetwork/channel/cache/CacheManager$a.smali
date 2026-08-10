.class Lanetwork/channel/cache/CacheManager$a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanetwork/channel/cache/CacheManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable<",
        "Lanetwork/channel/cache/CacheManager$a;",
        ">;"
    }
.end annotation


# instance fields
.field final a:Lanetwork/channel/cache/Cache;

.field final b:Lanetwork/channel/cache/CachePrediction;

.field final c:I


# direct methods
.method constructor <init>(Lanetwork/channel/cache/Cache;Lanetwork/channel/cache/CachePrediction;I)V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lanetwork/channel/cache/CacheManager$a;->a:Lanetwork/channel/cache/Cache;

    iput-object p2, p0, Lanetwork/channel/cache/CacheManager$a;->b:Lanetwork/channel/cache/CachePrediction;

    iput p3, p0, Lanetwork/channel/cache/CacheManager$a;->c:I

    return-void
.end method


# virtual methods
.method public a(Lanetwork/channel/cache/CacheManager$a;)I
    .locals 1

    iget v0, p0, Lanetwork/channel/cache/CacheManager$a;->c:I

    .line 31
    iget p1, p1, Lanetwork/channel/cache/CacheManager$a;->c:I

    sub-int/2addr v0, p1

    return v0
.end method

.method public synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    .line 19
    check-cast p1, Lanetwork/channel/cache/CacheManager$a;

    invoke-virtual {p0, p1}, Lanetwork/channel/cache/CacheManager$a;->a(Lanetwork/channel/cache/CacheManager$a;)I

    move-result p1

    return p1
.end method
