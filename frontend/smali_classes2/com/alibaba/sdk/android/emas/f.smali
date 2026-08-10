.class public Lcom/alibaba/sdk/android/emas/f;
.super Ljava/lang/Object;
.source "EmasLog.java"


# instance fields
.field private final b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/emas/g;",
            ">;"
        }
    .end annotation
.end field

.field private final c:Lcom/alibaba/sdk/android/emas/d;

.field private final c:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/emas/g;",
            ">;)V"
        }
    .end annotation

    .line 12
    sget-object v0, Lcom/alibaba/sdk/android/emas/d;->a:Lcom/alibaba/sdk/android/emas/d;

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/emas/f;-><init>(Ljava/util/List;Lcom/alibaba/sdk/android/emas/d;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljava/util/List;Lcom/alibaba/sdk/android/emas/d;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/emas/g;",
            ">;",
            "Lcom/alibaba/sdk/android/emas/d;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/f;->b:Ljava/util/List;

    iput-object p2, p0, Lcom/alibaba/sdk/android/emas/f;->c:Lcom/alibaba/sdk/android/emas/d;

    iput-object p3, p0, Lcom/alibaba/sdk/android/emas/f;->c:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a()Lcom/alibaba/sdk/android/emas/d;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/f;->c:Lcom/alibaba/sdk/android/emas/d;

    return-object v0
.end method

.method public a()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/emas/g;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/f;->b:Ljava/util/List;

    return-object v0
.end method

.method public getLocation()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/f;->c:Lcom/alibaba/sdk/android/emas/d;

    .line 30
    sget-object v1, Lcom/alibaba/sdk/android/emas/d;->b:Lcom/alibaba/sdk/android/emas/d;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/f;->c:Ljava/lang/String;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
