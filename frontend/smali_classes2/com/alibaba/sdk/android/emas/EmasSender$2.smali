.class Lcom/alibaba/sdk/android/emas/EmasSender$2;
.super Ljava/lang/Object;
.source "EmasSender.java"

# interfaces
.implements Lcom/alibaba/sdk/android/emas/i$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/emas/EmasSender;-><init>(Lcom/alibaba/sdk/android/emas/EmasSender$Builder;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/emas/EmasSender;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/emas/EmasSender;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/EmasSender$2;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public c()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/EmasSender$2;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    const/4 v1, 0x0

    .line 69
    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2102(Lcom/alibaba/sdk/android/emas/EmasSender;Z)Z

    return-void
.end method

.method public d()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/EmasSender$2;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    const/4 v1, 0x1

    .line 74
    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2102(Lcom/alibaba/sdk/android/emas/EmasSender;Z)Z

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/EmasSender$2;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 75
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2200(Lcom/alibaba/sdk/android/emas/EmasSender;)Lcom/alibaba/sdk/android/emas/c;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/c;->flush()V

    return-void
.end method
