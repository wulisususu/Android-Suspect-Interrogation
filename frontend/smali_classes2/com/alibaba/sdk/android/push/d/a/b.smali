.class public Lcom/alibaba/sdk/android/push/d/a/b;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/ams/common/b/a;


# instance fields
.field final a:Lcom/alibaba/sdk/android/ams/common/b/b;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/alibaba/sdk/android/push/d/a/a;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/d/a/a;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/d/a/b;->a:Lcom/alibaba/sdk/android/ams/common/b/b;

    return-void
.end method


# virtual methods
.method public a()Lcom/alibaba/sdk/android/ams/common/b/b;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/d/a/b;->a:Lcom/alibaba/sdk/android/ams/common/b/b;

    return-object v0
.end method
