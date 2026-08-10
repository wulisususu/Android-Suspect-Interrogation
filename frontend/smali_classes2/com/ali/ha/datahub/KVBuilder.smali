.class public Lcom/ali/ha/datahub/KVBuilder;
.super Ljava/lang/Object;
.source "KVBuilder.java"


# instance fields
.field private hasBuild:Z

.field private values:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/ali/ha/datahub/KVBuilder;->values:Ljava/util/HashMap;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/ali/ha/datahub/KVBuilder;->hasBuild:Z

    return-void
.end method

.method public static obtain()Lcom/ali/ha/datahub/KVBuilder;
    .locals 1

    .line 15
    new-instance v0, Lcom/ali/ha/datahub/KVBuilder;

    invoke-direct {v0}, Lcom/ali/ha/datahub/KVBuilder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public build()Ljava/util/HashMap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/ali/ha/datahub/KVBuilder;->hasBuild:Z

    iget-object v0, p0, Lcom/ali/ha/datahub/KVBuilder;->values:Ljava/util/HashMap;

    return-object v0
.end method

.method public putKV(Ljava/lang/String;Ljava/lang/String;)Lcom/ali/ha/datahub/KVBuilder;
    .locals 1

    iget-boolean v0, p0, Lcom/ali/ha/datahub/KVBuilder;->hasBuild:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/ali/ha/datahub/KVBuilder;->values:Ljava/util/HashMap;

    .line 19
    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-object p0
.end method
