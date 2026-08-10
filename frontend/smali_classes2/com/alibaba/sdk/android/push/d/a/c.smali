.class public Lcom/alibaba/sdk/android/push/d/a/c;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/ams/common/c/a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/alibaba/sdk/android/ams/common/c/a<",
        "Lcom/alibaba/sdk/android/ams/common/b/a;",
        ">;"
    }
.end annotation


# instance fields
.field private final a:Lcom/alibaba/sdk/android/push/d/a/b;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/alibaba/sdk/android/push/d/a/b;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/d/a/b;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/d/a/c;->a:Lcom/alibaba/sdk/android/push/d/a/b;

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "Lcom/alibaba/sdk/android/ams/common/b/a;",
            ">;"
        }
    .end annotation

    const-class v0, Lcom/alibaba/sdk/android/ams/common/b/a;

    return-object v0
.end method

.method public synthetic b()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/d/a/c;->c()Lcom/alibaba/sdk/android/ams/common/b/a;

    move-result-object v0

    return-object v0
.end method

.method public c()Lcom/alibaba/sdk/android/ams/common/b/a;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/d/a/c;->a:Lcom/alibaba/sdk/android/push/d/a/b;

    return-object v0
.end method
