.class public Lcom/alibaba/ha/core/AliHaCore$b;
.super Ljava/lang/Object;
.source "AliHaCore.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/core/AliHaCore;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "b"
.end annotation


# static fields
.field public static a:Lcom/alibaba/ha/core/AliHaCore;


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    .line 37
    new-instance v0, Lcom/alibaba/ha/core/AliHaCore;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/ha/core/AliHaCore;-><init>(Lcom/alibaba/ha/core/AliHaCore$a;)V

    sput-object v0, Lcom/alibaba/ha/core/AliHaCore$b;->a:Lcom/alibaba/ha/core/AliHaCore;

    return-void
.end method

.method public static synthetic a()Lcom/alibaba/ha/core/AliHaCore;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/core/AliHaCore$b;->a:Lcom/alibaba/ha/core/AliHaCore;

    return-object v0
.end method
