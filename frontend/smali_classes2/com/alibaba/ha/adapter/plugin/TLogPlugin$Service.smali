.class public Lcom/alibaba/ha/adapter/plugin/TLogPlugin$Service;
.super Ljava/lang/Object;
.source "TLogPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/adapter/plugin/TLogPlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Service"
.end annotation


# static fields
.field public static inited:Z = false


# direct methods
.method public static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 122
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic access$002(Z)Z
    .locals 0

    sput-boolean p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$Service;->inited:Z

    return p0
.end method

.method public static updateUserNick(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$Service;->inited:Z

    if-eqz v0, :cond_0

    .line 127
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/TLogInitializer;->updateUserNick(Ljava/lang/String;)V

    :cond_0
    return-void
.end method
