/* gio-unix-2.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "G", lower_case_cprefix = "g_")]
namespace GLib {
	[CCode (cheader_filename = "gio/gdesktopappinfo.h")]
	public class DesktopAppInfo : GLib.Object, GLib.AppInfo {
		[CCode (has_construct_function = false)]
		public DesktopAppInfo (string desktop_id);
		[CCode (has_construct_function = false)]
		public DesktopAppInfo.from_filename (string filename);
		[CCode (has_construct_function = false)]
		public DesktopAppInfo.from_keyfile (GLib.KeyFile key_file);
		public unowned string get_filename ();
		public bool get_is_hidden ();
		public static void set_desktop_env (string desktop_env);
	}
	[CCode (cheader_filename = "gio/gunixconnection.h")]
	public class UnixConnection : GLib.SocketConnection {
		[CCode (has_construct_function = false)]
		protected UnixConnection ();
		public unowned GLib.Credentials receive_credentials (GLib.Cancellable cancellable) throws GLib.Error;
		public int receive_fd (GLib.Cancellable cancellable) throws GLib.Error;
		public bool send_credentials (GLib.Cancellable cancellable) throws GLib.Error;
		public bool send_fd (int fd, GLib.Cancellable cancellable) throws GLib.Error;
	}
	[CCode (cheader_filename = "gio/gunixfdmessage.h")]
	public class UnixFDMessage : GLib.SocketControlMessage {
		[CCode (type = "GSocketControlMessage*", has_construct_function = false)]
		public UnixFDMessage ();
		public bool append_fd (int fd) throws GLib.Error;
		public unowned GLib.UnixFDList get_fd_list ();
		public int steal_fds (int length);
		[CCode (type = "GSocketControlMessage*", has_construct_function = false)]
		public UnixFDMessage.with_fd_list (GLib.UnixFDList fd_list);
		public GLib.UnixFDList fd_list { get; construct; }
	}
	[CCode (cheader_filename = "gio/gunixinputstream.h")]
	public class UnixInputStream : GLib.InputStream {
		[CCode (type = "GInputStream*", has_construct_function = false)]
		public UnixInputStream (int fd, bool close_fd);
		public bool get_close_fd ();
		public int get_fd ();
		public void set_close_fd (bool close_fd);
		public bool close_fd { get; set; }
		public int fd { get; construct; }
	}
	[Compact]
	[CCode (free_function = "g_unix_mount_free", cheader_filename = "gio/gunixmounts.h")]
	public class UnixMountEntry {
		[CCode (cname = "g_unix_mount_at")]
		public UnixMountEntry (string mount_path, uint64 time_read);
		[CCode (cname = "g_unix_mount_compare")]
		public int compare (GLib.UnixMountEntry mount);
		[CCode (cname = "g_unix_mounts_get")]
		public static GLib.List<GLib.UnixMountEntry> @get (ref uint64? time_read = null);
		[CCode (cname = "g_unix_mount_get_device_path")]
		public unowned string get_device_path ();
		[CCode (cname = "g_unix_mount_get_fs_type")]
		public unowned string get_fs_type ();
		[CCode (cname = "g_unix_mount_get_mount_path")]
		public unowned string get_mount_path ();
		[CCode (cname = "g_unix_mount_guess_can_eject")]
		public bool guess_can_eject ();
		[CCode (cname = "g_unix_mount_guess_icon")]
		public unowned GLib.Icon guess_icon ();
		[CCode (cname = "g_unix_mount_guess_name")]
		public unowned string guess_name ();
		[CCode (cname = "g_unix_mount_guess_should_display")]
		public bool guess_should_display ();
		[CCode (cname = "g_unix_mount_is_readonly")]
		public bool is_readonly ();
		[CCode (cname = "g_unix_mount_is_system_internal")]
		public bool is_system_internal ();
	}
	[CCode (cheader_filename = "gio/gunixmounts.h")]
	public class UnixMountMonitor : GLib.Object {
		[CCode (has_construct_function = false)]
		public UnixMountMonitor ();
		public void set_rate_limit (int limit_msec);
		public virtual signal void mountpoints_changed ();
		public virtual signal void mounts_changed ();
	}
	[Compact]
	[CCode (cheader_filename = "gio/gunixmounts.h")]
	public class UnixMountMonitorClass {
	}
	[Compact]
	[CCode (cheader_filename = "gio/gunixmounts.h")]
	public class UnixMountPoint {
		public int compare (GLib.UnixMountPoint mount2);
		public unowned string get_device_path ();
		public unowned string get_fs_type ();
		public unowned string get_mount_path ();
		public bool guess_can_eject ();
		public unowned GLib.Icon guess_icon ();
		public unowned string guess_name ();
		public bool is_loopback ();
		public bool is_readonly ();
		public bool is_user_mountable ();
	}
	[CCode (cheader_filename = "gio/gunixoutputstream.h")]
	public class UnixOutputStream : GLib.OutputStream {
		[CCode (type = "GOutputStream*", has_construct_function = false)]
		public UnixOutputStream (int fd, bool close_fd);
		public bool get_close_fd ();
		public int get_fd ();
		public void set_close_fd (bool close_fd);
		public bool close_fd { get; set; }
		public int fd { get; construct; }
	}
	[CCode (cheader_filename = "gio/gunixsocketaddress.h")]
	public class UnixSocketAddress : GLib.SocketAddress, GLib.SocketConnectable {
		[CCode (type = "GSocketAddress*", has_construct_function = false)]
		public UnixSocketAddress (string path);
		public static bool abstract_names_supported ();
		[CCode (cname = "g_unix_socket_address_new_abstract", type = "GSocketAddress*", has_construct_function = false)]
		public UnixSocketAddress.as_abstract (string path, int path_len);
		public GLib.UnixSocketAddressType get_address_type ();
		public bool get_is_abstract ();
		public unowned string get_path ();
		public size_t get_path_len ();
		[CCode (type = "GSocketAddress*", has_construct_function = false)]
		public UnixSocketAddress.with_type (string path, int path_len, GLib.UnixSocketAddressType type);
		[NoAccessorMethod]
		public bool @abstract { get; construct; }
		public GLib.UnixSocketAddressType address_type { get; construct; }
		public string path { get; construct; }
		[NoAccessorMethod]
		public GLib.ByteArray path_as_array { owned get; construct; }
	}
	[CCode (cheader_filename = "gio/gunixmounts.h")]
	public interface DesktopAppInfoLookup : GLib.Object {
		public abstract unowned GLib.AppInfo get_default_for_uri_scheme (string uri_scheme);
	}
	[CCode (cheader_filename = "gio/gunixmounts.h")]
	public interface FileDescriptorBased : GLib.Object {
		public abstract int get_fd ();
	}
	[CCode (cheader_filename = "gio/gunixmounts.h")]
	public const string DESKTOP_APP_INFO_LOOKUP_EXTENSION_POINT_NAME;
	[CCode (cname = "g_unix_is_mount_path_system_internal", cheader_filename = "gio/gunixmounts.h")]
	public static bool is_mount_path_system_internal (string mount_path);
	[CCode (cname = "g_unix_mount_points_changed_since", cheader_filename = "gio/gunixmounts.h")]
	public static bool mount_points_changed_since (uint64 time);
	[CCode (cname = "g_unix_mounts_changed_since", cheader_filename = "gio/gunixmounts.h")]
	public static bool mounts_changed_since (uint64 time);
}
