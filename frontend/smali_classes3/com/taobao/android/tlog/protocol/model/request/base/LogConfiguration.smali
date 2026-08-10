.class public Lcom/taobao/android/tlog/protocol/model/request/base/LogConfiguration;
.super Ljava/lang/Object;
.source "LogConfiguration.java"


# instance fields
.field private appenders:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/android/tlog/protocol/model/request/base/RollingFileAppender;",
            ">;"
        }
    .end annotation
.end field

.field private destroy:Ljava/lang/Boolean;

.field private enable:Ljava/lang/Boolean;

.field private loggers:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/android/tlog/protocol/model/request/base/Logger;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
